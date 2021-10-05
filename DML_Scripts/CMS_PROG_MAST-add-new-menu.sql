
INSERT
INTO cms_prog_mast
  (
    CPM_INST_CODE,
    CPM_PROG_CODE,
    CPM_TAB_TYPE,
    CPM_MENU_LINK,
    CPM_PROG_NAME,
    CPM_MENU_PATH,
    CPM_MENU_DESC,
    CPM_PROG_ORDER,
    CPM_PROG_STAT,
    CPM_INS_USER,
    CPM_INS_DATE,
    CPM_LUPD_USER,
    CPM_LUPD_DATE,
    CPM_ADMIN_MENU
  )
  VALUES
  (
    1,
    (SELECT MAX(cpm_prog_code)+1 FROM cms_prog_mast
    ),
    'P',
    2093,
    'Failed SMS Retry',
    '/cms/ProcessScheduler/FailedSMSRetry.jsp',
    'cms.menu.prog.FailedSMSRetry',
    216.4,
    'Y',
    1,
    sysdate,
    1,
    sysdate,
    'N'
  );