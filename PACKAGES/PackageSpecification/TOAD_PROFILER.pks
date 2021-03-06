CREATE OR REPLACE PACKAGE VMSCMS.toad_profiler is
  procedure rollup_unit(run_number IN number, UnitNumber IN number,
    UnitType IN varchar2, UnitOwner IN varchar2, UnitName IN varchar2);
  procedure rollup_run(run_number IN number);
  procedure rollup_all_runs;
end toad_profiler;
/


CREATE OR REPLACE PACKAGE BODY VMSCMS.toad_profiler is
  -- compute the total time spent executing this unit - the sum of the
  -- time spent executing lines in this unit (for this run)

  procedure rollup_unit(run_number IN number, UnitNumber IN number,
    UnitType IN varchar2, UnitOwner IN varchar2, UnitName IN varchar2) is

  TYPE TSourceTable IS TABLE OF VARCHAR2(4000) INDEX BY BINARY_INTEGER;
  SourceTable TSourceTable;
  TriggerBody long;
  FoundTriggerSource boolean;
  Cnt number;
  LnStart number;
  LnEnd   number;
  Pos number;
  vText varchar2(4000);
  IsWrapped boolean;
  TotalTime number;

  -- Select the lines for the unit to find source code
  cursor cLines(run_number number, UnitNumber number) is
    select line# from plsql_profiler_data
    where runid = run_number and unit_number = UnitNumber;
  begin
    select sum(total_time) into TotalTime
      from plsql_profiler_data
      where runid = run_number and unit_number = UnitNumber;

    if TotalTime IS NULL then
      TotalTime := 0;
    end if;

    update plsql_profiler_units set total_time = TotalTime
    where runid = run_number and unit_number = UnitNumber;

    -- Get trigger source into index-by table
    if UnitType = 'TRIGGER' then
      begin
        FoundTriggerSource := True;
        select trigger_body into TriggerBody
          from all_triggers where owner = UnitOwner and trigger_name = UnitName;
      exception
        when NO_DATA_FOUND then
          FoundTriggerSource := False;
      end;

      if FoundTriggerSource then
        Cnt     := 1;
        LnStart := 1;

        loop
          LnEnd := INSTR(TriggerBody, CHR(10), 1, Cnt);

          if (LnEnd = 0) then
            SourceTable(Cnt) := SubStr(TriggerBody, LnStart);
          else
            SourceTable(Cnt) := Substr(TriggerBody, LnStart, (LnEnd-LnStart));
          end if;

          LnStart := LnStart + (LnEnd-LnStart)+1;
          Cnt := Cnt+1;

          exit when (lnEnd = 0);
        end loop;
      end if;
    -- see if the code is wrapped
    else
      begin
        select upper(text) into vtext from all_source s
          where s.type = UnitType and s.owner = UnitOwner and
                s.name = UnitName and s.line = 1;
        IsWrapped := (INSTR(vText, ' WRAPPED') > 0);
      exception
        when NO_DATA_FOUND then
          IsWrapped := False;
      end;
    end if;

    -- Get the source for each line in unit
    Cnt := 1;
    for linerec in cLines(run_number, UnitNumber) loop
      if UnitType = 'TRIGGER' then
        if FoundTriggerSource then
          vText := SourceTable(linerec.line#);
        else
          if Cnt = 1 then
            vText := '<source unavailable>';
          else
            vText := null;
          end if;
        end if;
      else
        if IsWrapped then
          if Cnt = 1 then
            vText := '<wrapped>';
          else
            vText := null;
          end if;
        else
          begin
            select text into vtext from all_source s
              where s.type = UnitType and s.owner = UnitOwner and
                    s.name = UnitName and s.line = linerec.line#;
          exception
            when NO_DATA_FOUND then
              vText := null;
          end;
        end if;
      end if;
      -- store the source line
      update plsql_profiler_data d set d.text = vText
      where d.runid = run_number and d.unit_number = UnitNumber and
            d.line# = linerec.line#;
      Cnt := Cnt+1;
    end loop;
  end rollup_unit;



  -- rollup all units for the given run
  procedure rollup_run(run_number IN number) is
    tabpos number;
    comment varchar2(2047);
    proc varchar2(256);
    --
    -- only select those units which have not been rolled up yet
    cursor cunits(run_number number) is
      select unit_number, unit_type, unit_owner, unit_name
        from plsql_profiler_units
        where runid = run_number and total_time = 0
        order by unit_number asc;
  begin
    -- Fix Oracle's calling a 'PACKAGE' a 'PACKAGE SPEC'
    update plsql_profiler_units set unit_type = 'PACKAGE'
    where runid = run_number and unit_type like 'PACKAGE SPEC%';

    -- parse the RUN_COMMENT column to get the procedure name
  	-- (note: this replaces the BI_PLSQL_PROFILER_RUNS trigger.
    select run_proc, run_comment into proc, comment
	  from plsql_profiler_runs where runid = run_number;
    if proc is null then
      tabpos := INSTR(comment, CHR(8));
        if tabpos > 0 THEN
          proc := SUBSTR(comment, tabpos+1);
          comment := SUBSTR(comment, 1, tabpos-1);
        else
          proc := 'ANONYMOUS BLOCK';
        end if;
        update plsql_profiler_runs
          set run_owner = USER, run_proc = proc, run_comment = comment
          where runid = run_number;
    end if;


    for unitrec in cunits(run_number) loop
      rollup_unit(run_number, unitrec.unit_number, unitrec.unit_type,
                  unitrec.unit_owner, unitrec.unit_name);
    end loop;
  end rollup_run;


  -- rollup all runs
  procedure rollup_all_runs is
    cursor crunid is
      select runid from plsql_profiler_runs order by runid asc;
  begin
    for runidrec in crunid loop
      rollup_run(runidrec.runid);
    end loop crunid;
    commit;
  end rollup_all_runs;
end toad_profiler;
/


