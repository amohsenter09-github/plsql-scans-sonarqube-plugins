CREATE OR REPLACE PACKAGE VMSCMS.cg$errors IS

   CG$ERROR_PACKAGE_VERSION CONSTANT VARCHAR2(20) := '1.1.0';


   -----------------------------------------------------------------------------
   -- Name:        GetErrors
   -- Description: Pops all messages off the stack and returns them in the order
   --              in which they were raised.
   -- Parameters:  none
   -- Returns:     The messages
   -----------------------------------------------------------------------------
   FUNCTION GetVersion return VARCHAR2;

   ---------------------------------------------------------------------------------
   -- Name:        GetErrors
   -- Description: Pops all messages off the stack and returns them in the order
   --              in which they were raised.
   -- Parameters:  none
   -- Returns:     The messages
   -----------------------------------------------------------------------------
   FUNCTION GetErrors
        return varchar2;

   -----------------------------------------------------------------------------
   -- Name:        pop
   -- Description: Take a message off stack
   --              Gets the error message that was last raised and removes it
   --              from the error stack.
   -- Parameters:  msg     Text message
   -- Returns:     TRUE    Message popped successfully
   --              FALSE   Stack was empty
   -----------------------------------------------------------------------------
   FUNCTION pop(msg OUT VARCHAR2)
           RETURN BOOLEAN;


   -----------------------------------------------------------------------------
   -- Name:        pop (overload)
   -- Description: Take a message off stack with full info
   -- Parameters:  msg      Ttext message
   --              error    ERRor or WARNing
   --              msg_type ORA, API or user TLA
   --              msg_id   Id of message
   --              loc      Location where error occured
   -- Returns:     TRUE     Message popped successfully
   --              FALSE    Stack was empty
   -----------------------------------------------------------------------------
   FUNCTION pop(msg        OUT VARCHAR2
               ,error      OUT VARCHAR2
               ,msg_type   OUT VARCHAR2
               ,msgid      OUT INTEGER
               ,loc        OUT VARCHAR2)
           RETURN BOOLEAN;


   -----------------------------------------------------------------------------
   -- Name:        pop_head
   -- Description: Take a message off stack from head
   --              Gets the error message that was last raised and removes it
   --              from the error stack.
   -- Parameters:  msg     Text message
   -- Returns:     TRUE    Message popped successfully
   --              FALSE   Stack was empty
   -----------------------------------------------------------------------------
   FUNCTION pop_head(msg OUT VARCHAR2)
           RETURN BOOLEAN;


   -----------------------------------------------------------------------------
   -- Name:        pop_head (overload)
   -- Description: Take a message off stack from head with full info
   -- Parameters:  msg      Ttext message
   --              error    ERRor or WARNing
   --              msg_type ORA, API or user TLA
   --              msg_id   Id of message
   --              loc      Location where error occured
   -- Returns:     TRUE     Message popped successfully
   --              FALSE    Stack was empty
   -----------------------------------------------------------------------------
   FUNCTION pop_head(msg        OUT VARCHAR2
                     ,error      OUT VARCHAR2
                     ,msg_type   OUT VARCHAR2
                     ,msgid      OUT INTEGER
                     ,loc        OUT VARCHAR2)
           RETURN BOOLEAN;


   -----------------------------------------------------------------------------
   -- Name:        raise_failure
   --
   -- Description: To raise the cg$error failure exception handler
   -----------------------------------------------------------------------------
   PROCEDURE raise_failure;


   -----------------------------------------------------------------------------
   -- Name:        clear
   -- Description: Clears the stack
   -- Parameters:  none
   -----------------------------------------------------------------------------
   PROCEDURE clear;


   -----------------------------------------------------------------------------
   -- Name:        push
   --
   -- Description: Put a message on stack with full info
   --
   -- Parameters:  msg      Text message
   --              error    ERRor or WARNing
   --              msg_type ORA, API or user TLA
   --              msg_id   Id of message
   --              loc      Location where error occured
   -----------------------------------------------------------------------------
   PROCEDURE push(msg          IN VARCHAR2
                 ,error        IN VARCHAR2 DEFAULT 'E'
                 ,msg_type     IN VARCHAR2 DEFAULT NULL
                 ,msgid        IN INTEGER  DEFAULT 0
                 ,loc          IN VARCHAR2 DEFAULT NULL);


   -----------------------------------------------------------------------------
   -- Name:        MsgGetText
   -- Description: Provides a mechanism for text translation.
   -- Parameters:  p_MsgNo    The Id of the message
   --              p_DfltText The Default Text
   --              p_Subst1 (to 4) Substitution strings
   --              p_LangId   The Language ID
   -- Returns:		Translated message
   -----------------------------------------------------------------------------
   FUNCTION MsgGetText(p_MsgNo    IN NUMBER,
                       p_DfltText IN VARCHAR2 DEFAULT NULL,
                       p_Subst1   IN VARCHAR2 DEFAULT NULL,
                       p_Subst2   IN VARCHAR2 DEFAULT NULL,
                       p_Subst3   IN VARCHAR2 DEFAULT NULL,
                       p_Subst4   IN VARCHAR2 DEFAULT NULL,
                       p_LangId   IN NUMBER   DEFAULT NULL)
           RETURN VARCHAR2;


   -----------------------------------------------------------------------------
   -- Name:        parse_constraint
   -- Description: Isolate constraint name from an Oracle error message
   -- Parameters:  msg     The actual Oracle error message
   --              type    type of constraint to find
   --                      (ERR_FOREIGN_KEY     Foreign key,
   --                       ERR_CHECK_CON       Check,
   --                       ERR_UNIQUE_KEY      Unique key,
   --                       ERR_DELETE_RESTRICT Restricted delete)
   -- Returns:     con_name Constraint found (NULL if none found)
   -----------------------------------------------------------------------------
   FUNCTION parse_constraint(msg  IN VARCHAR2
                            ,type IN INTEGER)
           RETURN VARCHAR2;



   --
   -- Exception raised when any API validation fails
   --
   cg$error EXCEPTION;


   --
   -- Standard Oracle Errors that are caught and processed by the API
   --
   mandatory_missing   EXCEPTION;
   check_violation     EXCEPTION;
   fk_violation        EXCEPTION;
   upd_mandatory_null  EXCEPTION;
   delete_restrict     EXCEPTION;
   uk_violation        EXCEPTION;
   resource_busy       EXCEPTION;
   no_data_found       EXCEPTION;
   trg_mutate          EXCEPTION;

   ERR_UK_UPDATE    CONSTANT VARCHAR2(240) := 'Unique key <p1> not updateable';
   ERR_FK_TRANS     CONSTANT VARCHAR2(240) := 'Foreign key <p1> not transferable';
   ERR_DEL_RESTRICT CONSTANT VARCHAR2(240) := 'Cannot delete <p1> row, matching <p2> found';
   VAL_MAND         CONSTANT VARCHAR2(240) := 'Value for <p1> is required';
   ROW_MOD	        CONSTANT VARCHAR2(240) := 'Update failed - please re-query as value for <p1> has been modified by another user<p2><p3>';
   ROW_LCK          CONSTANT VARCHAR2(240) := 'Row is locked by another user';
   ROW_DEL          CONSTANT VARCHAR2(240) := 'Row no longer exists';
   APIMSG_PK_VIOLAT CONSTANT VARCHAR2(240) := 'Primary key <p1> on table <p2> violated';
   APIMSG_UK_VIOLAT CONSTANT VARCHAR2(240) := 'Unique constraint <p1> on table <p2> violated';
   APIMSG_FK_VIOLAT CONSTANT VARCHAR2(240) := 'Foreign key <p1> on table <p2> violated';
   APIMSG_CK_VIOLAT CONSTANT VARCHAR2(240) := 'Check constraint <p1> on table <p2> violated';
   APIMSG_ARC_MAND_VIOLAT   CONSTANT VARCHAR2(240) := 'Mandatory Arc <p1> on <p2> has not been satisfied';
   APIMSG_ARC_VIOLAT        CONSTANT VARCHAR2(240) := 'Too many members in Arc <p1> on <p2>';
   APIMSG_RV_TAB_NOT_FOUND  CONSTANT VARCHAR2(240) := 'Reference code table <p1> has not been created used for <p2>';
   APIMSG_RV_LOOKUP_FAIL    CONSTANT VARCHAR2(240) := 'Invalid value <p1> for column <p2>.<p3>';
   APIMSG_RV_LOOKUP_DO_FAIL CONSTANT VARCHAR2(240) := 'Invalid value <p1> in domain <p2> for column <p3>.<p4>';
   APIMSG_CODE_CTL_LOCKED   CONSTANT VARCHAR2(240) := 'Control table sequence value <p1> is being used by another user';
   APIMSG_FK_VALUE_REQUIRED CONSTANT VARCHAR2(240) := 'Value required for <p1> foreign key';
   APIMSG_CASC_ERROR        CONSTANT VARCHAR2(240) := 'Error in cascade <p1>';
   APIMSG_DO_LOOKUP_DO_FAIL CONSTANT VARCHAR2(240) := 'Invalid values in domain constraint <p1> referring domain table <p2> for table <p3>';


   API_UNIQUE_KEY_UPDATE   CONSTANT    INTEGER := 1001;
   API_FOREIGN_KEY_TRANS   CONSTANT    INTEGER := 1002;
   API_MODIFIED            CONSTANT    INTEGER := 1003;
   API_CK_CON_VIOLATED     CONSTANT    INTEGER := 1004;
   API_FK_CON_VIOLATED     CONSTANT    INTEGER := 1005;
   API_UQ_CON_VIOLATED     CONSTANT    INTEGER := 1006;
   API_PK_CON_VIOLATED     CONSTANT    INTEGER := 1007;
   API_MAND_COLUMN_ISNULL  CONSTANT    INTEGER := 1008;
   API_MAND_ARC_EMPTY      CONSTANT    INTEGER := 1009;
   API_ARC_TOO_MANY_VAL    CONSTANT    INTEGER := 1010;
   API_DEL_RESTRICT        CONSTANT    INTEGER := 1011;
   API_RV_TAB_NOT_FOUND    CONSTANT    INTEGER := 1012;
   API_RV_LOOKUP_FAIL      CONSTANT    INTEGER := 1013;
   API_RV_LOOKUP_DO_FAIL   CONSTANT    INTEGER := 1014;
   API_CODE_CTL_LOCKED     CONSTANT    INTEGER := 1015;
   API_FK_VALUE_REQUIRED   CONSTANT    INTEGER := 1016;
   API_CASC_ERROR          CONSTANT    INTEGER := 1017;
   API_ROW_MOD             CONSTANT    INTEGER := 1018;
   API_ROW_LCK             CONSTANT    INTEGER := 1019;
   API_ROW_DEL             CONSTANT    INTEGER := 1020;


   ERR_FOREIGN_KEY     CONSTANT    INTEGER := -2291;
   ERR_CHECK_CON       CONSTANT    INTEGER := -2290;
   ERR_UNIQUE_KEY      CONSTANT    INTEGER := -1;
   ERR_MAND_MISSING    CONSTANT    INTEGER := -1400;
   ERR_UPDATE_MAND     CONSTANT    INTEGER := -1407;
   ERR_RESOURCE_BUSY   CONSTANT    INTEGER := -54;
   ERR_NO_DATA         CONSTANT    INTEGER :=  1403;
   ERR_DELETE_RESTRICT CONSTANT    INTEGER := -2292;



   PRAGMA EXCEPTION_INIT(mandatory_missing,    -1400);
   PRAGMA EXCEPTION_INIT(check_violation,      -2290);
   PRAGMA EXCEPTION_INIT(fk_violation,         -2291);
   PRAGMA EXCEPTION_INIT(upd_mandatory_null,   -1407);
   PRAGMA EXCEPTION_INIT(delete_restrict,      -2292);
   PRAGMA EXCEPTION_INIT(uk_violation,         -0001);
   PRAGMA EXCEPTION_INIT(resource_busy,        -0054);
   PRAGMA EXCEPTION_INIT(trg_mutate,           -4091);

   PRAGMA EXCEPTION_INIT(cg$error,           -20999);

   TYPE cg$err_msg_t       IS TABLE OF VARCHAR2(512)   INDEX BY BINARY_INTEGER;
   TYPE cg$err_error_t     IS TABLE OF VARCHAR2(1)     INDEX BY BINARY_INTEGER;
   TYPE cg$err_msg_type_t  IS TABLE OF VARCHAR2(3)     INDEX BY BINARY_INTEGER;
   TYPE cg$err_msgid_t     IS TABLE OF INTEGER         INDEX BY BINARY_INTEGER;
   TYPE cg$err_loc_t       IS TABLE OF VARCHAR2(240)   INDEX BY BINARY_INTEGER;
   cg$err_tab_i INTEGER := 1;


END cg$errors;
/


CREATE OR REPLACE PACKAGE BODY VMSCMS.cg$errors IS

   cg$err_msg      cg$err_msg_t;
   cg$err_error    cg$err_error_t;
   cg$err_msg_type cg$err_msg_type_t;
   cg$err_msgid    cg$err_msgid_t;
   cg$err_loc      cg$err_loc_t;

   FUNCTION GetVersion return VARCHAR2 is
   BEGIN
      return CG$ERROR_PACKAGE_VERSION;
   END;

   -----------------------------------------------------------------------------
   -- Name:        get_errors
   -- Description: Pops all messages off the stack and returns them in the order
   --              in which they were raised.
   -- Parameters:  none
   -- Returns:     The messages
   -----------------------------------------------------------------------------
   FUNCTION GetErrors
         return varchar2  is
      I_ERROR_MESS  varchar2(2000):='';
      I_NEXT_MESS   varchar2(240):='';
   BEGIN
     while cg$errors.pop(I_NEXT_MESS) loop
       if I_ERROR_MESS is null then
          I_ERROR_MESS := I_NEXT_MESS;
       else
          I_ERROR_MESS := I_NEXT_MESS || '
   ' || I_ERROR_MESS;
       end if;
     end loop;
     return (I_ERROR_MESS);
   END;

   -----------------------------------------------------------------------------
   -- Name:        get_errors
   -- Description: Pops all messages off the stack and returns them in the order
   --              in which they were raised.
   -- Parameters:  none
   -- Returns:     The messages
   -----------------------------------------------------------------------------
   FUNCTION LookErrors
         return varchar2  is
      I_ERROR_MESS  varchar2(2000):='';
   BEGIN

     FOR i IN 1..cg$err_tab_i-1 LOOP
       IF I_ERROR_MESS IS NULL THEN
         I_ERROR_MESS := 'TAPI-' || to_char(cg$err_msgid(i)) || ':' || cg$err_msg(i);
       ELSE
         I_ERROR_MESS := I_ERROR_MESS || '
           ' || 'TAPI-' || to_char(cg$err_msgid(i)) || ':' || cg$err_msg(i);
       END IF;
     END LOOP;

     return (I_ERROR_MESS);
   END;

   --------------------------------------------------------------------------------
   -- Name:        raise_failure
   --
   -- Description: To raise the cg$error failure exception handler
   --------------------------------------------------------------------------------
   PROCEDURE raise_failure IS
   BEGIN
       raise_application_error(-20999, LookErrors);
   END raise_failure;

   --------------------------------------------------------------------------------
   -- Name:        parse_constraint
   -- Description: Isolate constraint name from an Oracle error message
   -- Parameters:  msg     The actual Oracle error message
   --              type    type of constraint to find
   --                      (ERR_FOREIGN_KEY     Foreign key,
   --                       ERR_CHECK_CON       Check,
   --                       ERR_UNIQUE_KEY      Unique key,
   --                       ERR_DELETE_RESTRICT Restricted delete)
   -- Returns:     con_name Constraint found (NULL if none found)
   --------------------------------------------------------------------------------
   FUNCTION parse_constraint(msg   IN VARCHAR2
                            ,type  IN INTEGER)
           RETURN VARCHAR2 IS
   con_name    VARCHAR2(100) := '';
   BEGIN

       IF (type = ERR_FOREIGN_KEY	OR
           type = ERR_CHECK_CON	OR
           type = ERR_UNIQUE_KEY	OR
           type = ERR_DELETE_RESTRICT) THEN
           con_name := substr(msg, instr(msg, '.') + 1, instr(msg, ')') - instr(msg, '.') - 1);
       END IF;

       return con_name;
   END;

   --------------------------------------------------------------------------------
   -- Name:        push
   --
   -- Description: Put a message on stack with full info
   --
   -- Parameters:  msg      Text message
   --              error    ERRor or WARNing
   --              msg_type ORA, API or user TLA
   --              msg_id   Id of message
   --              loc      Location where error occured
   --------------------------------------------------------------------------------
   PROCEDURE push(msg      IN VARCHAR2
                 ,error    IN VARCHAR2  DEFAULT 'E'
                 ,msg_type IN VARCHAR2  DEFAULT NULL
                 ,msgid    IN INTEGER   DEFAULT 0
                 ,loc      IN VARCHAR2  DEFAULT NULL) IS
   BEGIN

       cg$err_msg(cg$err_tab_i)        := msg;
       cg$err_error(cg$err_tab_i)      := error;
       cg$err_msg_type(cg$err_tab_i)   := msg_type;
       cg$err_msgid(cg$err_tab_i)      := msgid;
       cg$err_loc(cg$err_tab_i)        := loc;
       cg$err_tab_i                    := cg$err_tab_i + 1;

   END push;

   --------------------------------------------------------------------------------
   -- Name:        pop
   -- Description: Take a message off stack
   -- Parameters:  msg     Text message
   -- Returns:     TRUE    Message popped successfully
   --              FALSE   Stack was empty
   --------------------------------------------------------------------------------
   FUNCTION pop(msg OUT VARCHAR2)
       RETURN BOOLEAN IS
   BEGIN

       IF (cg$err_tab_i > 1 AND cg$err_msg(cg$err_tab_i - 1) IS NOT NULL) THEN
           cg$err_tab_i := cg$err_tab_i - 1;
           msg          := cg$err_msg(cg$err_tab_i);
           cg$err_msg(cg$err_tab_i) := '';
           return TRUE;
       ELSE
           return FALSE;
       END IF;

   END pop;

   --------------------------------------------------------------------------------
   -- Name:        pop (overload)
   -- Description: Take a message off stack with full info
   -- Parameters:  msg      Ttext message
   --              error    ERRor or WARNing
   --              msg_type ORA, API or user TLA
   --              msg_id   Id of message
   --              loc      Location where error occured
   -- Returns:     TRUE     Message popped successfully
   --              FALSE    Stack was empty
   --------------------------------------------------------------------------------
   FUNCTION pop(msg        OUT VARCHAR2
               ,error      OUT VARCHAR2
               ,msg_type   OUT VARCHAR2
               ,msgid      OUT INTEGER
               ,loc        OUT VARCHAR2)
           RETURN BOOLEAN IS
   BEGIN

       IF (cg$err_tab_i > 1 AND cg$err_msg(cg$err_tab_i - 1) IS NOT NULL) THEN
           cg$err_tab_i := cg$err_tab_i - 1;
           msg          := cg$err_msg(cg$err_tab_i);
           cg$err_msg(cg$err_tab_i) := '';
           error        := cg$err_error(cg$err_tab_i);
           msg_type     := cg$err_msg_type(cg$err_tab_i);
           msgid        := cg$err_msgid(cg$err_tab_i);
           loc          := cg$err_loc(cg$err_tab_i);
           return TRUE;
       ELSE
           return FALSE;
       END IF;

   END pop;


   --------------------------------------------------------------------------------
   -- Name:        pop_head
   -- Description: Take a message off stack from head
   -- Parameters:  msg     Text message
   -- Returns:     TRUE    Message popped successfully
   --              FALSE   Stack was empty
   --------------------------------------------------------------------------------
   FUNCTION pop_head(msg OUT VARCHAR2)
       RETURN BOOLEAN IS
   BEGIN

       IF (cg$err_tab_i > 1 AND cg$err_msg(cg$err_tab_i - 1) IS NOT NULL) THEN
           msg          := cg$err_msg(1);

           FOR i IN 1..cg$err_tab_i-2 LOOP
              cg$err_msg(i) := cg$err_msg(i+1);
              cg$err_error(i) := cg$err_error(i+1);
              cg$err_msg_type(i) := cg$err_msg_type(i+1);
              cg$err_msgid(i) := cg$err_msgid(i+1);
              cg$err_loc(i) := cg$err_loc(i+1);
           END LOOP;

           cg$err_tab_i := cg$err_tab_i - 1;
           cg$err_msg(cg$err_tab_i) := '';
           return TRUE;
       ELSE
           return FALSE;
       END IF;

   END pop_head;


   --------------------------------------------------------------------------------
   -- Name:        pop_head (overload)
   -- Description: Take a message off stack from head with full info
   -- Parameters:  msg      Ttext message
   --              error    ERRor or WARNing
   --              msg_type ORA, API or user TLA
   --              msg_id   Id of message
   --              loc      Location where error occured
   -- Returns:     TRUE     Message popped successfully
   --              FALSE    Stack was empty
   --------------------------------------------------------------------------------
   FUNCTION pop_head(msg        OUT VARCHAR2
                     ,error      OUT VARCHAR2
                     ,msg_type   OUT VARCHAR2
                     ,msgid      OUT INTEGER
                     ,loc        OUT VARCHAR2)
           RETURN BOOLEAN IS
   BEGIN

       IF (cg$err_tab_i > 1 AND cg$err_msg(cg$err_tab_i - 1) IS NOT NULL) THEN
           msg          := cg$err_msg(1);
           error        := cg$err_error(1);
           msg_type     := cg$err_msg_type(1);
           msgid        := cg$err_msgid(1);
           loc          := cg$err_loc(1);

           FOR i IN 1..cg$err_tab_i-2 LOOP
              cg$err_msg(i) := cg$err_msg(i+1);
              cg$err_error(i) := cg$err_error(i+1);
              cg$err_msg_type(i) := cg$err_msg_type(i+1);
              cg$err_msgid(i) := cg$err_msgid(i+1);
              cg$err_loc(i) := cg$err_loc(i+1);
           END LOOP;

           cg$err_tab_i := cg$err_tab_i - 1;
           cg$err_msg(cg$err_tab_i) := '';

           return TRUE;
       ELSE
           return FALSE;
       END IF;

   END pop_head;


   --------------------------------------------------------------------------------
   -- Name:        clear
   -- Description: Clears the stack
   -- Parameters:  none
   --------------------------------------------------------------------------------
   PROCEDURE clear IS
   BEGIN

       cg$err_tab_i := 1;

   END clear;

   --------------------------------------------------------------------------------
   -- Name:        MsgGetText
   -- Description: Provides a mechanism for text translation.
   -- Parameters:  p_MsgNo    The Id of the message
   --              p_DfltText The Default Text
   --              p_Subst1 (to 4) Substitution strings
   --              p_LangId   The Language ID
   -- Returns:		Translated message
   --------------------------------------------------------------------------------
   FUNCTION MsgGetText(p_MsgNo in number
                      ,p_DfltText in varchar2
                      ,p_Subst1 in varchar2
                      ,p_Subst2 in varchar2
                      ,p_Subst3 in varchar2
                      ,p_Subst4 in varchar2
                      ,p_LangId in number)
            RETURN varchar2 IS
      l_temp varchar2(10000) := p_DfltText;
   BEGIN

      l_temp := replace(l_temp, '<p>',  p_Subst1);
      l_temp := replace(l_temp, '<p1>', p_Subst1);
      l_temp := replace(l_temp, '<p2>', p_Subst2);
      l_temp := replace(l_temp, '<p3>', p_Subst3);
      l_temp := replace(l_temp, '<p4>', p_Subst4);

      return l_temp;

   END MsgGetText;

END cg$errors;
/


