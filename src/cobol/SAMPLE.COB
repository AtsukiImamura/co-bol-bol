      *---1---------2---------3---------4---------5-----
       IDENTIFICATION         DIVISION.
       PROGRAM-ID.            SAMPLE.
      *
       ENVIRONMENT            DIVISION.
       INPUT-OUTPUT           SECTION.
       FILE-CONTROL.
         SELECT  IN-FL        ASSIGN TO 'infile.dat'
                              ORGANIZATION IS LINE SEQUENTIAL.
         SELECT  OUT-FL       ASSIGN TO 'outfile.dat'.
      *
       DATA                   DIVISION.
       FILE                   SECTION.
       FD  IN-FL              LABEL RECORD STANDARD
                              BLOCK CONTAINS 0 RECORDS.
       01  IN-REC             PIC X(10).
       FD  OUT-FL             LABEL RECORD OMITTED.
       01  OUT-REC            PIC X(10).
       WORKING-STORAGE        SECTION.
       01  IN-DATA.
         03  IN-STR           PIC X(10).
       01  FLG-EOF            PIC X(01).
      *
       PROCEDURE              DIVISION.
      *-- ﾌﾟﾛｸﾞﾗﾑﾉﾌﾛｰ
       PGM-FLOW               SECTION.
       PGM-FLOW-S.
         PERFORM              PGM-OPEN.
         PERFORM              PGM-RW
           UNTIL              FLG-EOF = '1'.
         PERFORM              PGM-CLOSE.
       PGM-FLOW-E.
         STOP RUN.
      *-- ﾌｧｲﾙOPEN AND ｼｮｶｲﾌｧｲﾙREAD
       PGM-OPEN               SECTION.
       PGM-OPEN-S.
         OPEN                 INPUT  IN-FL
                              OUTPUT OUT-FL.
         MOVE                 SPACE  TO  FLG-EOF.
         PERFORM              PGM-READ.
       PGM-OPEN-E.
         EXIT.
      *-- ﾌｧｲﾙREAD
       PGM-READ               SECTION.
       PGM-READ-S.
         READ                 IN-FL  INTO  IN-DATA
           AT END
             MOVE             '1'  TO  FLG-EOF
         END-READ.
       PGM-READ-E.
         EXIT.
      *-- ﾌｧｲﾙWRITE AND ﾂｷﾞﾉﾌｧｲﾙREAD
       PGM-RW                 SECTION.
       PGM-RW-S.
      *   WRITE                OUT-REC FROM IN-DATA AFTER 1.
         WRITE                "HELLO WORLD!".
         PERFORM              PGM-READ.
       PGM-RW-E.
         EXIT.
      *-- ﾌｧｲﾙCLOSE
       PGM-CLOSE              SECTION.
       PGM-CLOSE-S.
         CLOSE                IN-FL
                              OUT-FL.
       PGM-CLOSE-E.
         EXIT.
