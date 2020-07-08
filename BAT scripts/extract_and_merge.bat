@echo off
setlocal EnableDelayedExpansion

set _inputprefix=C:\Temp\cell\CellTrackingChallenge\
set _outputprefix=Scripts\

REM set _dir1=Fluo-N2DH-SIM+\01_GT\SEG\
REM set _dir2=Fluo-N2DH-SIM+\02_GT\SEG\
REM set _dir3=Fluo-N2DH-SIM+\01_GT\TRA\
REM set _dir4=Fluo-N2DH-SIM+\02_GT\TRA\


REM set _dir1=Fluo-N2DL-HeLa\01_GT\SEG\
REM set _dir2=Fluo-N2DL-HeLa\02_GT\SEG\
REM set _dir3=Fluo-N2DL-HeLa\01_GT\TRA\
REM set _dir4=Fluo-N2DL-HeLa\02_GT\TRA\
REM set _dir5=Fluo-N2DL-HeLa\01_ST\SEG\
REM set _dir6=Fluo-N2DL-HeLa\02_ST\SEG\

REM set _dir7=DIC-C2DH-HeLa\01_GT\SEG\
REM set _dir8=DIC-C2DH-HeLa\02_GT\SEG\
REM set _dir9=DIC-C2DH-HeLa\01_GT\TRA\
REM set _dir10=DIC-C2DH-HeLa\02_GT\TRA\
REM set _dir11=DIC-C2DH-HeLa\01_ST\SEG\
REM set _dir12=DIC-C2DH-HeLa\02_ST\SEG\


set _dir1=BF-C2DL-MuSC\01_GT\SEG\
set _dir2=BF-C2DL-MuSC\02_GT\SEG\
set _dir3=BF-C2DL-MuSC\01_GT\TRA\
set _dir4=BF-C2DL-MuSC\02_GT\TRA\
REM set _dir5=Fluo-C2DL-MSC\01_ST\SEG\
REM set _dir6=Fluo-C2DL-MSC\02_ST\SEG\

REM set _dir7=PhC-C2DL-PSC\01_GT\SEG\
REM set _dir8=PhC-C2DL-PSC\02_GT\SEG\
REM set _dir9=PhC-C2DL-PSC\01_GT\TRA\
REM set _dir10=PhC-C2DL-PSC\02_GT\TRA\
REM set _dir11=PhC-C2DL-PSC\01_ST\SEG\
REM set _dir12=PhC-C2DL-PSC\02_ST\SEG\

set table[1]=BFC2DLMuSC
set table[2]=BFC2DLMuSC
set table[3]=BFC2DLMuSC
set table[4]=BFC2DLMuSC
REM set table[5]=FluoC2DLMSC
REM set table[6]=FluoC2DLMSC

REM set table[7]=PhCC2DLPSC
REM set table[8]=PhCC2DLPSC
REM set table[9]=PhCC2DLPSC
REM set table[10]=PhCC2DLPSC
REM set table[11]=PhCC2DLPSC
REM set table[12]=PhCC2DLPSC

set _dataset[1]=01-GT-SEG-
set _dataset[2]=02-GT-SEG-
set _dataset[3]=01-GT-TRA-
set _dataset[4]=02-GT-TRA-
REM set _dataset[5]=01-ST-SEG-
REM set _dataset[6]=02-ST-SEG-

set _manfileprefix[1]=man_seg
set _manfileprefix[2]=man_seg
set _manfileprefix[3]=man_track
set _manfileprefix[4]=man_track
REM set _manfileprefix[5]=man_seg
REM set _manfileprefix[6]=man_seg

REM set _dataset[7]=01-GT-SEG-
REM set _dataset[8]=02-GT-SEG-
REM set _dataset[9]=01-GT-TRA-
REM set _dataset[10]=02-GT-TRA-
REM set _dataset[11]=01-ST-SEG-
REM set _dataset[12]=02-ST-SEG-

REM set _manfileprefix[7]=man_seg
REM set _manfileprefix[8]=man_seg
REM set _manfileprefix[9]=man_track
REM set _manfileprefix[10]=man_track
REM set _manfileprefix[11]=man_seg
REM set _manfileprefix[12]=man_seg

set _maxtime=1500
set _maxcells=150
set _numdigits=4
set _i=0

REM for %%d in (!_dir1! !_dir2! !_dir3! !_dir4! !_dir5! !_dir6! !_dir7! !_dir8! !_dir9! !_dir10! !_dir11! !_dir12!) do (
for %%d in (!_dir1! !_dir2! !_dir3! !_dir4!) do (

	set /A _i+=1
	set _segmented_dir=!_outputprefix!%%dsegmented
	set _merged_dir=!_outputprefix!%%dmerged
	
	mkdir !_segmented_dir!
	mkdir !_merged_dir!

	call set _tab=%%table[!_i!]%%
	call set _set=%%_dataset[!_i!]%%
	call set _man_file=%%_manfileprefix[!_i!]%%
	
	for /L %%n in (0,1,%_maxtime%) do (
      		set _fv=000000%%n
      		set _fv2=!_fv:~-%_numdigits%!
      		set _ffile=!_inputprefix!%%d\!_man_file!!_fv2!.tif
      		set _ofile=!_segmented_dir!\cell!_fv2!-
      		call cell_extraction -i !_ffile! -o !_ofile!
	)
	
	for /L %%c in (1,1,%_maxcells%) do (
  		set _ffile2=!_merged_dir!\cell%%c.wkt
  		set _fScript=!_outputprefix!\!_tab!Data.sql

  		for /L %%n in (0,1,%_maxtime%) do (
     			set _fv=000000%%n
     			set _fv2=!_fv:~-%_numdigits%!
     			set _ofile=!_segmented_dir!\cell!_fv2!-%%c.wkt
     			set _fullfile=!_ofile!
     			if exist !_fullfile! (
        			echo |set /p=%%n; >> !_ffile2!
				type !_ofile! >> !_ffile2!
				set "_line=insert into !_tab! ^(^time, name, object^)^ values (%%n, '!_set!cell%%c','"
				for /F "usebackq tokens=*" %%A in (!_ofile!) do set _line=!_line!%%A
				set "_line=!_line!'^)^;"
				if NOT "!_line:~125,1!"==""  (
					echo !_line! >> !_fScript!
				)
     			)
  		)
	)
)

