@echo off

set arg=%1
set param=%2
title PureSky���ƹ��� [����ѡ�У�����ס�������Ҽ���س���Ŵ���С����]
setlocal enableDelayedExpansion
color 0F


::���ϵͳ�ܹ�
if "!PROCESSOR_ARCHITECTURE!" EQU "x86" (
	echo.
	echo.[%time:~0,8%] ��֧��32λϵͳ��
	echo.
	pause
	exit
)
echo.[%time:~0,8%] ϵͳ�ܹ����ͨ��
echo.[%time:~0,8%] ϵͳ�ܹ����ͨ��>!diyId!_log.log


::�ļ��Լ�
if exist bin\checkfile.list (
	echo.[%time:~0,8%] ���ڼ���ļ�...
	echo.[%time:~0,8%] ���ڼ���ļ�...>>!diyId!_log.log
	for /f %%i in ('type bin\checkfile.list ^|findstr -v "#"') do (
		set file=%%i
		if exist !file! (
			echo.[%time:~0,8%] !file! ... OK
			echo.[%time:~0,8%] !file! ... OK >>!diyId!_log.log
		) else (
			set fileLoss=yes
			if exist bin\Windows_NT\x86_64\cecho.exe (
				bin\Windows_NT\x86_64\cecho.exe {0C}!file! ... Failed{0F}{\n}
				bin\Windows_NT\x86_64\cecho.exe {0C}!file! ... Failed{0F}{\n} >>!diyId!_log.log
				bin\Windows_NT\x86_64\cecho.exe {0C}�ļ���ʧ: !file!{0F}{\n}
				bin\Windows_NT\x86_64\cecho.exe {0C}�ļ���ʧ: !file!{0F}{\n} >>!diyId!_log.log
			) else (
				color 0C
				echo.[%time:~0,8%] !file! ...... Failed
				echo.[%time:~0,8%] !file! ...... Failed>>!diyId!_log.log
				echo.[%time:~0,8%] �ļ���ʧ: !file!
				echo.[%time:~0,8%] �ļ���ʧ: !file!>>!diyId!_log.log
			)
		)
	)
	if "!fileLoss!" == "yes" (
		echo.
		echo.[%time:~0,8%] �ļ��Լ첻ͨ����ĳЩ�ļ��Ѿ���ʧ���޷��������й���
		echo.[%time:~0,8%] �ļ��Լ첻ͨ����ĳЩ�ļ��Ѿ���ʧ���޷��������й���>>!diyId!_log.log
		echo.
		pause
		exit
	)
) else (
	echo.
	echo.[%time:~0,8%] ����ļ���ʧ����ȷ�Ϲ����Ƿ���������ѹ
	echo.[%time:~0,8%] ����ļ���ʧ����ȷ�Ϲ����Ƿ���������ѹ>>!diyId!_log.log
	echo.
	pause
	exit
)
echo.[%time:~0,8%] �ļ��Լ�ͨ��
echo.[%time:~0,8%] �ļ��Լ�ͨ��>>!diyId!_log.log


::busybox
if not exist bin\busybox (
	echo.[%time:~0,8%] ��������Busybox...
	echo.[%time:~0,8%] ��������Busybox...>>!diyId!_log.log
	md bin\busybox
	copy bin\Windows_NT\x86_64\busybox.exe bin\busybox\busybox.exe 1>nul 2>nul
	for /f %%i in ('bin\busybox\busybox.exe --list ^|findstr -v busybox') do (
		echo.[%time:~0,8%] �������ӣ�bin\busybox\busybox.exe -^> bin\busybox\%%i.exe
		echo.[%time:~0,8%] �������ӣ�bin\busybox\busybox.exe -^> bin\busybox\%%i.exe>>!diyId!_log.log
		mklink !CD!\bin\busybox\%%i.exe !CD!\bin\busybox\busybox.exe 1>nul 2>nul
	)
)


::���Jre
java -jar bin\apktool\apktool.jar 1>nul 2>nul || (
	echo.
	echo.[%time:~0,8%] �������а�װ java��jre�� ����!
	echo.[%time:~0,8%] �������а�װ java��jre�� ����!
	echo.[%time:~0,8%] �������а�װ java��jre�� ����!
	echo.[%time:~0,8%] �������а�װ java��jre�� ����!>>!diyId!_log.log
	echo.
	start https://www.java.com/zh-CN/download/
	pause
	exit
)
echo.[%time:~0,8%] Java���ͨ��
echo.[%time:~0,8%] Java���ͨ��>>!diyId!_log.log


::�״δ�ʱ����
if not exist bin\user.psky (
	start bin\������־.txt
	start bin\�ļ�ϵͳ����һ�����ض���.txt
)


::�������� - ������ʡȥ·��
echo.[%time:~0,8%] ���û�������... 
echo.[%time:~0,8%] ���û�������... >>!diyId!_log.log
set PATH=%CD%\bin\busybox;%CD%\bin\Windows_NT\x86_64;%CD%\bin\Windows_NT\x86_64\extra;%PATH%
echo.[%time:~0,8%] ��������:
echo.[%time:~0,8%] ��������: >>!diyId!_log.log
echo.%PATH% |sed "s/;/\n/g" |sed "s/^/[%time:~0,8%] &/g"
echo.%PATH% |sed "s/;/\n/g" |sed "s/^/[%time:~0,8%] &/g" >>!diyId!_log.log
set RED=call :PRINTRED
set CYAN=call :PRINTCYAN
set GREEN=call :PRINTGREEN
set YELLOW=call :PRINTYELLOW
if "!param!" == "--admin" goto MAIN
if "!arg!" NEQ "--debug" cls


::: ����̷�ʣ��ռ�
set currentDisk=%~d0
!CYAN! ��ǰ·��: !CD!
for /f %%i in ('"wmic LOGICALDISK get freespace,name" ^|findstr !currentDisk! ^|tr -cd 0-9') do (set diskByte=%%i)
for /f %%i in ('echo.!diskByte!/1024/1024/1024 ^|bc') do (set diskGB=%%i)
!CYAN! ��ǰ�̷�: !currentDisk! ��ʣ�ռ��ԼΪ: !diskGB!GB
if "!diskGB!" == "" (
	echo.
	!RED! �����̿ռ����
	echo.
	pause
	exit
)
if !diskGB! LEQ 15 (
	echo.
	!RED! ��ʣ�ռ䲻����������������������ٽ���
	!RED! ��ʣ�ռ䲻����������������������ٽ���
	!RED! ��ʣ�ռ䲻����������������������ٽ���
	echo.
	pause
	exit
)
if !diskGB! LEQ 20 (
	!YELLOW! ��ʣ�ռ���ܲ�������������
	set /p sureToMake="�Ƿ������(Y/N)[Ĭ��:N]->"
	if /i "!sureToMake!" NEQ "y" exit
) else (
	!GREEN! �̷���ʣ�ռ�������������
)

::: ���Է���������
!CYAN! �������ӷ�����...
curl -sS "https://jk.511i.cn" 1>nul 2>nul
if not errorlevel 0 (
	echo.
	!RED! �޷����ӵ�"PureSky"�����������������������
	!RED! �޷����ӵ�"PureSky"�����������������������
	!RED! �޷����ӵ�"PureSky"�����������������������
	echo.
	pause
	exit
) else (
	!GREEN! �ɹ����ӷ�����
)

::: ������
set toolLocalVersion=V230511Fix
title PureSky���ƹ���-!toolLocalVersion! [����ѡ�У�����ס�������Ҽ���س���Ŵ���С����]
!YELLOW! ���ڻ�ȡ�汾��Ϣ
for /f %%i in ('curl -skS "xxxx" 2^>nul ^|awk NR^=^=1') do (set toolLatestVersion=%%i)
for /f %%i in ('curl -skS "xxxx" 2^>nul ^|awk NR^=^=2') do (set toolLink=%%i)
!CYAN! ���ذ汾[!toolLocalVersion!]
!CYAN! �ƶ˰汾[!toolLatestVersion!]
if not errorlevel 0 (
	echo.
	!RED!��ȡ�汾��Ϣʧ��
	echo.
	!YELLOW! ��������������
	echo.
	pause
	exit
)
if "!toolLocalVersion!" NEQ "!toolLatestVersion!" (
	!YELLOW! �������°湤�ߣ�!toolLatestVersion!
	!YELLOW! �°湤�����ӣ�!toolLink!
	!YELLOW! ������ȡ�룺g1an
	start !toolLink!
	pause
	exit
) else (
	!GREEN! ����Ϊ���°棺!toolLocalVersion!
)

::��ʼ�����
!YELLOW! ^=^=^=^=^=^=^=^=^=^=^=
!GREEN! ��ʼ�����
!YELLOW! ^=^=^=^=^=^=^=^=^=^=^=
sleep 1

::: ��ʾ��Ϣ
if "!arg!" NEQ "--debug" cls
echo.[%time:~0,8%] ROM����Ҫ��:
!YELLOW! �����������뱣����������
!YELLOW! ������������ر�����ɱ��������ܼҡ���ʿ��
!YELLOW! ���벻Ҫ������ڣ�������ǰ�治Ҫ��"ѡ��"���֣��������뿴����
!GREEN! ���� https://jk.511i.cn
cecho [%time:~0,8%] {0A}ע�� http://jk.511i.cn/?index=register{0F}{\n}
cecho [%time:~0,8%] {0A}���ܹ��� http://www.kami.vip/purchasing?link=FTo333{0F}{\n}
echo.
!CYAN! �Ķ���Ҫ����������ʼ
pause >nul

::: ����¼
:OnLogin
if "!arg!" NEQ "--debug" cls
set myUsername=
set myPassword=
!CYAN! ���ڼ���¼��Ϣ
if exist bin\user.psky (
	for /f %%i in ('cat bin/user.psky ^|awk NR^=^=1 ^|base32 -d ^|sed "s/ //g"') do (set myUsername=%%i)
	for /f %%i in ('cat bin/user.psky ^|awk NR^=^=2 ^|base32 -d ^|sed "s/ //g"') do (set myPassword=%%i)
	!YELLOW! �����Ա�����Ϣ��¼[!myUsername!]
	for /f %%i in ('curl -skS "xxxx"') do (set loginState=%%i)
	if "!loginState!" == "login_successfully" (
		echo.!myUsername! |base32 >bin\user.psky
		echo.!myPassword! |base32 >>bin\user.psky
		!GREEN! ��¼�ɹ���!myUsername!
		sleep 1
		goto MAIN
	) else (
		del bin\user.psky 1>nul 2>nul
		echo.
		curl -skS "xxxx"
		sleep 1
		goto OnLogin
	)
) else (
	!YELLOW! ����δ������Ϣ�����¼
	set /p myUsername="[%time:~0,8%] ����������˺ţ�"
	set /p myPassword="[%time:~0,8%] ������������룺"
	for /f %%i in ('curl -skS "xxxx"') do (set loginState=%%i)
	if "!loginState!" == "login_successfully" (
		echo.!myUsername! |base32 >bin\user.psky
		echo.!myPassword! |base32 >>bin\user.psky
		!CYAN! ��¼�ɹ���!myUsername!
		sleep 1
		goto MAIN
	) else (
		del bin\user.psky 1>nul 2>nul
		echo.
		curl -skS "xxxx"
		sleep 1
		goto OnLogin
	)
)


::��ʼ
:MAIN
if "!arg!" NEQ "--debug" cls
set myDiyId=
!CYAN! ��ǰ·��:!CD!
!CYAN! ��ǰ�û�:!myUsername!
set /p myDiyId="[%time:~0,8%] �������㴦���Ŷ��еĶ��ƺ�:"

::������
for /f %%i in ('echo.!myDiyId! ^|findstr http') do (set tmpLink=%%i)
if "!tmpLink!" neq "" (
	echo.DIY_ID=test>bin\diy.psky
	set diyId=test
	echo.!myDiyId!>>bin\diy.psky
	echo.{common}>>bin\diy.psky
	goto ANALYSE
)
if "!myDiyId!" == "" goto MAIN


::�ӹ�����ȡ����
!YELLOW! ���ڽ������ͺ�ROM��Ϣ...
curl -skS "xxxx" >bin\diy.psky
if not errorlevel 0 (
	!RED! ����������ʧ��,����3�������
	sleep 3
	goto MAIN
)

for /f "tokens=2 delims==" %%i in ('type bin\diy.psky ^|findstr DIY_ID') do (set diyId=%%i)
if "!diyId!" == "" (
	echo.
	curl -skS "xxxx" |iconv -f utf8 -t gbk |sed "s/^/[%time:~0,8%] &/g"
	echo.
	echo.
	!RED! ������Ϣ����,����3�������
	sleep 3
	goto MAIN
)


::������ROM���Ͳ���
:ANALYSE
	if exist !diyId!_log.log del !diyId!_log.log 1>nul 2>nul
	if exist _log.log move _log.log !diyId!_log.log 1>nul 2>nul
	for /f %%i in ('type bin\diy.psky ^|findstr http ^|findstr zip') do (set romLink=%%i)
	for /f %%i in ('basename !romLink!') do (set romName=%%i)
	for /f %%i in ('echo.!romName! ^|cut -d "_" -f 2 ^|sed "s/PRE//"') do (set deviceCode=%%i)
	for /f "tokens=3 delims=_" %%i in ('echo.!romName!') do (set romVersion=%%i)
	for /f "tokens=4 delims=_" %%i in ('echo.!romName!') do (set romHash=%%i)
	for /f %%i in ('echo.!romName! ^|cut -d "_" -f 5 ^|cut -d "." -f 1') do (set androidVersion=%%i)
	for /f "tokens=2 delims=_" %%i in ('type bin\puresky\device_info.txt ^|findstr "!deviceCode!_"') do (set deviceName=%%i)
	for /f "tokens=3 delims=_" %%i in ('type bin\puresky\device_info.txt ^|findstr "!deviceCode!_"') do (set devicePlatform=%%i)
	for /f "tokens=4 delims=_" %%i in ('type bin\puresky\device_info.txt ^|findstr "!deviceCode!_"') do (set deviceArch=%%i)
	for /f "tokens=5 delims=_" %%i in ('type bin\puresky\device_info.txt ^|findstr "!deviceCode!_"') do (set flashType=%%i)
	if "!deviceName!" == "" set deviceName=!deviceCode!
	!GREEN! ���ʹ���: !deviceCode!
	!GREEN! ��������: !deviceName!
	!GREEN! ��������: !deviceArch!
	!GREEN! ˢ����ʽ: !flashType!
	!GREEN! CPU ����: !devicePlatform!
	!GREEN! ROM �汾: !romVersion!
	!GREEN! ��׿�汾: !androidVersion!
	!GREEN! ��ϣƬ��: !romHash!

!CYAN! ���������ļ�...
call :CLEANUP
::�ύ��ץȡ����
call :SUBMITPROGRESS 1 ץȡ
if exist input\!romName! (
	!CYAN! ���ش���Ŀ��ROM�������ڸ���...
	cp -rf input/!romName! tmp/
	goto EXTRACT
)


::����ROM
!YELLOW! ���ز�����Ŀ��ROM����������ROM��
set dsum=0
call :SUBMITPROGRESS 13 ����


:DOWNLOAD
	set /a dsum+=1
	call :WRITELOG ���ش�����!dsum!
	if "!dsum!" == "1" (!CYAN! ��ʼ���� !romName!)
	!YELLOW! [����] [- - - - - - - - - - - - - - - - - - - - - - - - --] [ �����ٶ� ] [ʣ��ʱ��]
	axel -n 8 -a https://bigota.d.miui.com/!romVersion!/!romName! -o tmp
	!CYAN! ������֤MD5ֵ...
	for /f %%i in ('md5sum tmp/!romName! 2^>nul ^|head -c 10') do (set localHash=%%i)
	!CYAN! ������Ƭ��Ϊ: !localHash!
	if "!localHash!" NEQ "!romHash!" (
		!RED! ����ʱ���ִ�����������
		goto DOWNLOAD
	)
	!GREEN! ROM�������


:EXTRACT
!YELLOW! ��ʼ��ȡ�ļ�
call :SUBMITPROGRESS 23 ��ȡ
!CYAN! ���ڽ�ѹROM��
7z x -y tmp\!romName! -otmp 1>nul 2>nul
set /p delRom="[%time:~0,8%] �Ƿ�ɾ��ԭ����(Y/N)[Ĭ��:N]->"
::set delRom=y
if /i "!delRom!" == "y" (
	!YELLOW! ɾ����ԭ����!romName!
	del tmp\!romName!
) else (
	!CYAN! ������ԭ��
	if not exist input md input
	if exist input\!romName! del input\!romName!
	move tmp\!romName! input\!romName! 1>nul 2>nul
)
if not exist tmp\payload.bin if not exist tmp\*system* (
	echo.
	!RED! ROM�����Ϲ淶,�����ɻ����
	echo.
	pause
	exit
)
call :SUBMITPROGRESS 35 �ֽ�

REM ��ȡsuper�б��Լ��ų��б�
for /f "tokens=2 delims==" %%i in ('type bin\configure.txt ^|findstr super_list') do (set superList=%%i)
for /f "tokens=2 delims==" %%i in ('type bin\configure.txt ^|findstr deny_list') do (set denyList=%%i)

:: payload.bin �� brotli ȫ������� xxx.img,�� tmp �µ�һ��Ŀ¼
if exist tmp\payload.bin (
	!YELLOW! ���� paylod.bin
	move tmp\payload.bin payload.bin 1>nul 2>nul
	rd /s /q tmp
	md tmp
	move payload.bin tmp\payload.bin 1>nul 2>nul
	!CYAN! ���ڷֽ� payload.bin
	payload-dumper-go -o tmp/images tmp/payload.bin 1>nul 2>nul
	if exist tmp\images\boot.img (
		!YELLOW! ���� boot.img
		move tmp\images\boot.img tmp\boot.img 1>nul 2>nul
	)
	if exist tmp\images\init_boot.img (	
		!YELLOW! ���� init_boot.img
		move tmp\images\init_boot.img tmp\init_boot.img 1>nul 2>nul
	)
	for %%i in (!superList!) do (
		set pname=%%i
		if exist tmp\images\!pname!.img (
			!GREEN! Super �ӷ���:!pname!_a
			call :WRITELOG logical_partition:!pname!_a detected
			move tmp\images\!pname!.img tmp\!pname!.img 1>nul 2>nul
		)
	)
	!GREEN! �ֽ����:payload.bin
	if "!deviceArch!" == "" set deviceArch=VAB
	del tmp\payload.bin 1>nul 2>nul
) else (
	if "!deviceArch!" == "" if exist tmp\dynamic_partitions_op_list set deviceArch=AonlyDynamic
	if "!deviceArch!" == "" if not exist tmp\dynamic_partitions_op_list set deviceArch=AonlyStatic
	for %%i in (!superList!) do (
		set pname=%%i
		if exist tmp\!pname!.new.dat.br (
			!CYAN! ���ڽ�ѹ !pname!.new.dat.br...
			brotli -d tmp/!pname!.new.dat.br -o tmp/!pname!.new.dat 1>nul 2>nul
			!CYAN! ���ڷֽ� !pname!.new.dat...
			sdat2img tmp/!pname!.transfer.list tmp/!pname!.new.dat tmp/!pname!.img 1>nul 2>nul
			del tmp\!pname!.transfer.list 1>nul 2>nul
			del tmp\!pname!.new.dat.br 1>nul 2>nul
			del tmp\!pname!.patch.dat 1>nul 2>nul
			del tmp\!pname!.new.dat 1>nul 2>nul
			if "!flashType!" == "TwoInOne" if "!deviceArch!" == "AonlyDynamic" call :WRITELOG logical_partition:!pname! detected
		)
	)
)


REM ��ȡ����
md tmp\config
md tmp\output


REM �����ų��б�
for %%i in (!denyList!) do (
	set pname=%%i
	if exist tmp\%%i.img (
		!YELLOW! ����[!pname!]���ų��б�
		move tmp\!pname!.img tmp\output\!pname!.img 1>nul 2>nul
	)
)

REM �ֽ⾵��
!CYAN! ��ʼ��ȡ����
for %%i in (!superList!) do (
	set pname=%%i
	if exist tmp\!pname!.img (
		call :EXTRACTIMG tmp/!pname!.img
	)
)

:CHECKNET_FIRST
curl -sS "https://jk.511i.cn" 1>nul 2>nul
if not errorlevel 0 (
	!RED! ���������������,�����������
	!YELLOW! �����������
	pause>nul
	goto CHECKNET_FIRST
) else (
	!GREEN! �������ͨ��
)

:: ��ʼ�޸�ROM
!YELLOW! ��ʼ�޸�ROM
call :SUBMITPROGRESS 42 �޸�
for /f "tokens=2 delims==" %%i in ('type bin\configure.txt ^|findstr default_magisk') do (set defaultMagisk=%%i)
if "!defaultMagisk!" == "" set defaultMagisk=26100
::: ��ȫ������
rm -rf config
cat bin/file_config/product_file_contexts_add.txt >>tmp/config/product_file_contexts
cat bin/file_config/product_fs_config_add.txt >>tmp/config/product_fs_config
cat bin/file_config/system_file_contexts_add.txt >>tmp/config/system_file_contexts
cat bin/file_config/system_fs_config_add.txt >>tmp/config/system_fs_config
cat bin/file_config/vendor_file_contexts_add.txt >>tmp/config/vendor_file_contexts
cat bin/file_config/vendor_fs_config_add.txt >>tmp/config/vendor_fs_config
::: ȥ������
bash bin/puresky/rmc |sed "s/^/[%time:~0,8%] &/g"
rm -rf tmp/system/verity_key
rm -rf tmp/vendor/verity_key
rm -rf tmp/product/verity_key
rm -rf tmp/system/recovery-from-boot.p
rm -rf tmp/vendor/recovery-from-boot.p
rm -rf tmp/product/recovery-from-boot.p
rm -rf tmp/product/media/theme/miui_mod_icons/com.google.android.apps.nbu
rm -rf tmp/product/media/theme/miui_mod_icons/com.google.android.apps.nbu.
rd /s /q \\?\!CD!\tmp\product\media\theme\miui_mod_icons\com.google.android.apps.nbu. 1>nul 2>nul
del /s /q \\?\!CD!\tmp\product\media\theme\miui_mod_icons\com.google.android.apps.nbu. 1>nul 2>nul
rm -rf tmp/product/media/theme/miui_mod_icons/dynamic/com.google.android.apps.nbu
rm -rf tmp/product/media/theme/miui_mod_icons/dynamic/com.google.android.apps.nbu.
rd /s /q \\?\!CD!\tmp\product\media\theme\miui_mod_icons\dynamic\com.google.android.apps.nbu. 1>nul 2>nul
del /s /q \\?\!CD!\tmp\product\media\theme\miui_mod_icons\dynamic\com.google.android.apps.nbu. 1>nul 2>nul
rm -rf tmp/system/system/media/theme/miui_mod_icons/com.google.android.apps.nbu
rm -rf tmp/system/system/media/theme/miui_mod_icons/com.google.android.apps.nbu.
rd /s /q \\?\!CD!\tmp\system\system\media\theme\miui_mod_icons\com.google.android.apps.nbu. 1>nul 2>nul
del /s /q \\?\!CD!\tmp\system\system\media\theme\miui_mod_icons\com.google.android.apps.nbu. 1>nul 2>nul
rm -rf tmp/system/system/media/theme/miui_mod_icons/dynamic/com.google.android.apps.nbu
rm -rf tmp/system/system/media/theme/miui_mod_icons/dynamic/com.google.android.apps.nbu.
rd /s /q \\?\!CD!\tmp\system\system\media\theme\miui_mod_icons\dynamic\com.google.android.apps.nbu. 1>nul 2>nul
del /s /q \\?\!CD!\tmp\system\system\media\theme\miui_mod_icons\dynamic\com.google.android.apps.nbu. 1>nul 2>nul
for /f %%j in ('busybox find tmp/ -maxdepth 2 -type f -name "vbmeta*.img"') do (
	set vbtarget=%%j
	if "!vbtarget!" NEQ "" (
		!YELLOW! Target vbmeta: !vbtarget!
		vbmeta-disable-verification !vbtarget! |sed "s/^/[%time:~0,8%] &/g"
	)
)
if exist tmp\product\pangu (
	!CYAN! �����޸�NFC
	bash bin/puresky/fixnfc.sh
	rm -rf system_fs_config_pangu
	rm -rf system_file_contexts_pangu
)
call :SUBMITPROGRESS 48 �޸�

for /f %%i in ('type bin\diy.psky ^|findstr common') do (set mode=%%i)

for /f "tokens=*" %%j in ('busybox find tmp/ -type f ^|findstr fstab ^|findstr /v "enableswap _"') do (
	set fstabfile=%%j
	sed -i "/overlay/d" !fstabfile!
)

REM �޸�
if "!mode!" == "{common}" (
	!YELLOW! �Գ���ٸİ����������޸�
	if exist tmp\product\media\theme\default cp -rf bin/puresky/com.android.settings tmp/product/media/theme/default/com.android.settings
	if exist tmp\system\system\media\theme\default cp -rf bin/puresky/com.android.settings tmp/system/system/media/theme/default/com.android.settings
	rm -rf tmp/product/etc/auto-install*
	rm -rf tmp/system/system/etc/auto-install*
	!CYAN! ������� Magisk-ROOT���汾��!defaultMagisk!
	7z x -y bin/Magisk/Magisk!defaultMagisk!.apk -otmp/magisk 1>nul 2>nul
	for /f %%i in ('dir /b /s tmp\magisk ^|findstr arm ^|findstr magisk32') do (set magisk32File=%%i)
	for /f %%i in ('dir /b /s tmp\magisk ^|findstr arm ^|findstr magisk64') do (set magisk64File=%%i)
	for /f %%i in ('dir /b /s tmp\magisk ^|findstr arm64 ^|findstr magiskinit') do (set magiskInitFile=%%i)
	if "!magiskInitFile!" equ "" for /f %%i in ('dir /b /s tmp\magisk ^|findstr arm ^|findstr magiskinit') do (set magiskInitFile=%%i)
	echo.[%time:~0,8%] magisk32 �ļ���!magisk32File!
	echo.[%time:~0,8%] magisk64 �ļ���!magisk64File!
	echo.[%time:~0,8%] magiskinit �ļ���!magiskInitFile!
	
	move tmp\magisk\assets\util_functions.sh !CD!\util_functions.sh 1>nul 2>nul
	move !magisk32File! !CD!\magisk32 1>nul 2>nul
	move !magisk64File! !CD!\magisk64 1>nul 2>nul
	move !magiskInitFile! !CD!\magiskinit 1>nul 2>nul
	if exist tmp\magisk\assets\stub.apk move tmp\magisk\assets\stub.apk !CD!\stub.apk 1>nul 2>nul
	
	
	bash bin/puresky/boot_patch.sh tmp/boot.img
	move new-boot.img tmp\output\boot_magisk.img 1>nul 2>nul
	move tmp\boot.img tmp\output\boot_official.img 1>nul 2>nul
	7z x -y bin\ramdisk\ramdisk.zip !androidVersion!-!deviceCode!-ramdisk.cpio -otmp 1>nul 2>nul
	if exist tmp\!androidVersion!-!deviceCode!-ramdisk.cpio (
		!CYAN! ���ںϲ�TWRP
		magiskboot unpack tmp/output/boot_official.img 1>nul 2>nul
		cp -rf tmp/!androidVersion!-!deviceCode!-ramdisk.cpio ramdisk.cpio
		rm tmp/!androidVersion!-!deviceCode!-ramdisk.cpio
		magiskboot repack tmp/output/boot_official.img 1>nul 2>nul
		mv new-boot.img twrp.img
		bash bin/puresky/boot_patch.sh twrp.img
		rm twrp.img
		mv new-boot.img tmp/output/boot_twrp.img
	)
	if exist tmp\init_boot.img (
		!YELLOW! �� init_boot.img �򲹶�
		bash bin/puresky/boot_patch.sh tmp/init_boot.img
		move new-boot.img tmp\output\init_boot_magisk.img 1>nul 2>nul
		move tmp\init_boot.img tmp\output\init_boot_official.img 1>nul 2>nul
	)
	rm -rf tmp/magisk 
	rm -rf magisk32 magisk64 magiskinit stub.apk util_functions.sh
	!CYAN! ����ȥ��Data����
	for /f %%i in ('busybox find tmp/ -type f ^|findstr fstab ^|findstr /v "enableswap _"') do (
		set fstabfile=%%i
		!YELLOW! ������Ŀ���ļ���!fstabfile!
		sed -i "s/ro,/ro,noatime,/g" !fstabfile!
		sed -i "s/,avb_keys=\/avb\/q-gsi.avbpubkey:\/avb\/r-gsi.avbpubkey:\/avb\/s-gsi.avbpubkey:\/avb\/t-gsi.avbpubkey//g" !fstabfile!
		sed -i "s/,avb=vbmeta_system//g" !fstabfile!
		sed -i "s/,avb=vbmeta_vendor//g" !fstabfile!
		sed -i "s/,avb=vbmeta//g" !fstabfile!
		sed -i "s/,avb//g" !fstabfile!
		sed -i "s/,fileencryption=aes-256-xts:aes-256-cts:v2+inlinecrypt_optimized+wrappedkey_v0//g" !fstabfile!
		sed -i "s/,fileencryption=aes-256-xts:aes-256-cts:v2+emmc_optimized+wrappedkey_v0//g" !fstabfile!
		sed -i "s/,fileencryption=aes-256-xts:aes-256-cts:v2//g" !fstabfile!
		sed -i "s/,metadata_encryption=aes-256-xts:wrappedkey_v0//g" !fstabfile!
		sed -i "s/,fileencryption=aes-256-xts:wrappedkey_v0//g" !fstabfile!
		sed -i "s/,metadata_encryption=aes-256-xts//g" !fstabfile!
		sed -i "s/,fileencryption=aes-256-xts//g" !fstabfile!
		sed -i "s/,fileencryption=ice//g" !fstabfile!
		sed -i "s/fileencryption/encryptable/g" !fstabfile!
	)
	
	!CYAN! �����޸�ȫ�ָ�ˢ
	bash bin/puresky/mkpk |sed "s/^/[%time:~0,8%] &/g"
	!CYAN! �����޸�������ˢ
	bash bin/puresky/mkui 0x3e8 |sed "s/^/[%time:~0,8%] &/g"
	!CYAN! ������������ƽ�
	::bash bin/puresky/thememanager
	for /f %%i in ('busybox find tmp/ -type f -name "*ThemeManager*.apk"') do (set themeApk=%%i)
	!YELLOW! ThemeManager: !themeApk!
	if "!androidVersion!" == "13" (
		cp -rf bin/apks/MIUIThemeManager_T.apk !themeApk!
	) else (
		cp -rf bin/apks/MIUIThemeManagre.apk !themeApk!
	)
	for /f %%j in ('busybox find tmp/ -type f -name init.miui.rc') do (set MiuiInitRC=%%j)
	for /f %%j in ('busybox find tmp/ -type f -name init.rc') do (set initRc=%%j)
	if "!MiuiInitRC!" neq "" (
		sed -i "/on boot/a\    chmod 0731 \/data\/system\/theme" !MiuiInitRC!
	)
	if "!MiuiInitRC!" equ "" if "!initRc!" neq "" (
		sed -i "/on boot/a\    chmod 0731 \/data\/system\/theme" !initRc!
	)
	
	cp -rf bin/puresky/busybox tmp/system/system/bin/busybox
	for /f %%j in ('type bin\diy.psky ^|findstr erofs2ext4') do (set erofs2ext4=%%j)
	if "!erofs2ext4!" == "{erofs2ext4}" (
		!CYAN! EROFS�ļ�ϵͳתEXT4
		if exist !diyId!_log.log sed -i "s/erofs/ext4/g" !diyId!_log.log
			for /f "tokens=*" %%j in ('busybox find tmp/ -type f ^|findstr fstab ^|findstr /v "enableswap _"') do (
			set fstabfile=%%j
			sed -i "/overlay/d" !fstabfile!
		)
	)
	
	for /f %%j in ('type bin\diy.psky ^|findstr ext42erofs') do (set ext42erofs=%%j)
	if "!ext42erofs!" == "{ext42erofs}" (
		!CYAN! EXT4�ļ�ϵͳתEROFS
		if exist !diyId!_log.log sed -i "s/ext4/erofs/g" !diyId!_log.log
	)
	!CYAN! ���DC���ⰴť
	for /f %%j in ('busybox find tmp/ -type d ^|findstr device_features ^| awk NR^=^=1') do (set deviceFeature=%%j)
	sed -i "s/<bool name=\"dc_backlight_fps_incompatible\">true<\/bool>/<bool name=\"dc_backlight_fps_incompatible\">false<\/bool>/" !deviceFeature!/*.xml
	sed -i "s/<bool name=\"support_dc_backlight\">false<\/bool>/<bool name=\"support_dc_backlight\">true<\/bool>/" !deviceFeature!/*.xml
	sed -i "s/<bool name=\"support_secret_dc_backlight\">true<\/bool>/<bool name=\"support_secret_dc_backlight\">false<\/bool>/" !deviceFeature!/*.xml
	!CYAN! ���90Hzˢ���ʰ�ť�����֧��120��
	sed -i "/<item>120<\/item>/a\\t\t<item>90<\/item>" !deviceFeature!/*.xml
	
	
	
	for /f %%i in ('echo.!deviceCode! ^|findstr "PHOENIX PICASSO"') do (set K30Device=%%i)
	if "!K30Device!" NEQ "" (
		if "!androidVersion!" GTR "11" (
			!CYAN! ������K30��ǿ�
			for /f %%i in ('busybox find tmp/ -type f -name DevicesOverlay.apk') do (
				set DevicesOverlay=%%i
				if "!DevicesOverlay!" NEQ "" (
					echo. Ŀ���ļ���!DevicesOverlay!
					cp -r bin/apks/DevicesOverlay.apk !DevicesOverlay!
				)
			)
		)
	)
	
	if "!androidVersion!" LSS "13" (
		for /f %%i in ('busybox find tmp/ -type f -name "M*PackageInstaller.apk"') do (
			set ApkInstaller=%%i
			if "!ApkInstaller!" NEQ "" (
				!CYAN! ��Ӿɰ�Ӧ�ð�װ��
				echo. Ŀ���ļ���!ApkInstaller!
				cp -rf bin/apks/MiuiPackageInstaller.apk !ApkInstaller!
			) else (
				!YELLOW! �Ҳ�����װ��λ��
			)
		)
	) else (
		for /f %%i in ('busybox find tmp/ -type f -name "M*PackageInstaller.apk"') do (
			set ApkInstaller=%%i
			if "!ApkInstaller!" NEQ "" (
				cp -rf bin/apks/MiuiPackageInstaller_T.apk !ApkInstaller!
			) else (
				!YELLOW! �Ҳ�����װ��λ��
			)
		)
	)
	
	call :SUBMITPROGRESS 53 �޸�
	!CYAN! �����޸��Ż����Ч��
	sed -i "s/sys.haptic.down.weak=.*/sys.haptic.down.weak=0/g" tmp/vendor/build.prop
	sed -i "s/sys.haptic.down.normal=.*/sys.haptic.down.normal=2/g" tmp/vendor/build.prop
	sed -i "s/sys.haptic.down.strong=.*/sys.haptic.down.strong=5/g" tmp/vendor/build.prop
	sed -i "s/sys.haptic.down=.*/sys.haptic.down=3,2/g" tmp/vendor/build.prop
	sed -i "s/sys.haptic.tap.normal=.*/sys.haptic.tap.normal=0,2/g" tmp/vendor/build.prop
	sed -i "s/sys.haptic.tap.light=.*/sys.haptic.tap.light=3,1/g" tmp/vendor/build.prop
	sed -i "s/sys.haptic.flick=.*/sys.haptic.flick=3,2/g" tmp/vendor/build.prop
	sed -i "s/sys.haptic.flick.light=.*/sys.haptic.flick.light=3,1/g" tmp/vendor/build.prop
	sed -i "s/sys.haptic.switch=.*/sys.haptic.switch=3,1/g" tmp/vendor/build.prop
	sed -i "s/sys.haptic.mesh.heavy=.*/sys.haptic.mesh.heavy=0,2/g" tmp/vendor/build.prop
	sed -i "s/sys.haptic.mesh.normal=.*/sys.haptic.mesh.normal=3,2/g" tmp/vendor/build.prop
	sed -i "s/sys.haptic.mesh.light=.*/sys.haptic.mesh.light=3,1/g" tmp/vendor/build.prop
	sed -i "s/sys.haptic.long.press=.*/sys.haptic.long.press=3,2/g" tmp/vendor/build.prop
	sed -i "s/sys.haptic.popup.normal=.*/sys.haptic.popup.normal=3,2/g" tmp/vendor/build.prop
	sed -i "s/sys.haptic.popup.light=.*/sys.haptic.popup.light=3,1/g" tmp/vendor/build.prop
	sed -i "s/sys.haptic.pickup=.*/sys.haptic.pickup=3,1/g" tmp/vendor/build.prop
	sed -i "s/sys.haptic.scroll.edge=.*/sys.haptic.scroll.edge=3,2/g" tmp/vendor/build.prop
	sed -i "s/sys.haptic.trigger.drawer=.*/sys.haptic.trigger.drawer=3,1/g" tmp/vendor/build.prop
	sed -i "s/sys.haptic.hold=.*/sys.haptic.hold=3,2/g" tmp/vendor/build.prop
	sed -i "s/sys.haptic.runin=.*/sys.haptic.runin=13/g" tmp/vendor/build.prop
	!CYAN! �������ģʽ����
	sed -i "$a\persist.sys.power.default.powermode=1" tmp/system/system/build.prop
	!CYAN! Ĭ��usb����
	sed -i "$a\persist.adb.notify=0" tmp/system/system/build.prop
	sed -i "$a\persist.sys.usb.config=mtp,adb" tmp/system/system/build.prop
	!YELLOW! ��ROM��Ϊ��׿!androidVersion!
	if "!androidVersion!" LSS "13" (
		!CYAN! ���ھ���Ӧ��
		rm -rf tmp/vendor/data-app/*
		rm -rf tmp/product/data-app/*
		rm -rf tmp/system/system/app/MSA
		rm -rf tmp/system/system/app/mab
		rm -rf tmp/system/system/priv-app/MSA
		rm -rf tmp/system/system/priv-app/mab
		rm -rf tmp/system/system/app/Updater
		rm -rf tmp/system/system/app/MiuiUpdater
		rm -rf tmp/system/system/priv-app/Updater
		rm -rf tmp/system/system/priv-app/MiuiUpdater
		rm -rf tmp/system/system/app/MiService
		rm -rf tmp/system/system/app/MIService
		rm -rf tmp/system/system/priv-app/MiService
		rm -rf tmp/system/system/priv-app/MIService
		rm -rf tmp/system/system/app/*Hybrid*
		rm -rf tmp/system/system/app/AnalyticsCore/*
		rm -rf tmp/system/system/media/wallpaper/wallpaper_group/01*
		rm -rf tmp/system/system/media/wallpaper/wallpaper_group/02*
		rm -rf tmp/system/system/media/wallpaper/wallpaper_group/03*
		rm -rf tmp/system/system/media/wallpaper/wallpaper_group/04*
		rm -rf tmp/system/system/media/wallpaper/wallpaper_group/05*
		rm -rf tmp/system/system/media/wallpaper/wallpaper_group/06*
		busybox mkdir tmp/APK
		mv tmp/system/system/data-app/*Weather* tmp/APK/ 1>nul 2>nul
		mv tmp/system/system/data-app/*Media* tmp/APK/ 1>nul 2>nul
		mv tmp/system/system/data-app/*SoundRecorder* tmp/APK/  1>nul 2>nul
		mv tmp/system/system/data-app/*ScreenRecorder* tmp/APK/ 1>nul 2>nul
		mv tmp/system/system/data-app/*Calculator* tmp/APK/ 1>nul 2>nul
		mv tmp/system/system/data-app/*GoogleContact* tmp/APK/  1>nul 2>nul
		rm -rf tmp/system/system/data-app/*
		cp -rf tmp/APK/* tmp/system/system/data-app
		rm -rf tmp/APK
		if exist tmp\system\system\app\AnalyticsCore cp bin/apks/AnalyticsCore.apk tmp/system/system/app/AnalyticsCore/AnalyticsCore.apk
	) else (
		!CYAN! ���ھ���Ӧ��
		rm -rf tmp/product/app/MSA
		rm -rf tmp/product/app/mab
		rm -rf tmp/system/system/app/MSA
		rm -rf tmp/system/system/app/mab
		rm -rf tmp/product/priv-app/MSA
		rm -rf tmp/system/system/priv-app/MSA
		rm -rf tmp/product/app/Updater
		rm -rf tmp/product/app/MiuiUpdater
		rm -rf tmp/product/priv-app/Updater
		rm -rf tmp/product/priv-app/MiuiUpdater
		rm -rf tmp/product/app/MiService
		rm -rf tmp/product/app/MIService
		rm -rf tmp/product/priv-app/MiService
		rm -rf tmp/product/priv-app/MIService
		rm -rf tmp/product/app/*Hybrid*
		rm -rf tmp/product/etc/auto-install*
		rm -rf tmp/product/app/AnalyticsCore/*
		rm -rf tmp/product/media/wallpaper/wallpaper_group/01*
		rm -rf tmp/product/media/wallpaper/wallpaper_group/02*
		rm -rf tmp/product/media/wallpaper/wallpaper_group/03*
		rm -rf tmp/product/media/wallpaper/wallpaper_group/04*
		rm -rf tmp/product/media/wallpaper/wallpaper_group/05*
		rm -rf tmp/product/media/wallpaper/wallpaper_group/06*
		busybox mkdir tmp/APK
		mv tmp/product/data-app/*Weather* tmp/APK/ 1>nul 2>nul
		mv tmp/product/data-app/*DeskClock* tmp/APK/ 1>nul 2>nul
		mv tmp/product/data-app/*Gallery tmp/APK/ 1>nul 2>nul
		mv tmp/product/data-app/*SoundRecorder* tmp/APK/ 1>nul 2>nul
		mv tmp/product/data-app/*ScreenRecorder* tmp/APK/ 1>nul 2>nul
		mv tmp/product/data-app/*Calculator* tmp/APK/ 1>nul 2>nul
		mv tmp/product/data-app/*Calendar tmp/APK/ 1>nul 2>nul
		mv tmp/product/data-app/*Media* tmp/APK/ 1>nul 2>nul
		mv tmp/product/data-app/*GoogleContact* tmp/APK/ 1>nul 2>nul
		rm -rf tmp/product/data-app/*
		cp -rf tmp/APK/* tmp/product/data-app
		rm -rf tmp/APK
		if exist tmp\product\app\AnalyticsCore cp bin/apks/AnalyticsCore.apk tmp/product/app/AnalyticsCore/AnalyticsCore.apk
		if exist tmp\system\system\app\AnalyticsCore cp bin/apks/AnalyticsCore.apk tmp/system/system/app/AnalyticsCore/AnalyticsCore.apk
	)
	if exist tmp\system\system\data-app (
		md tmp\system\system\data-app\Magisk
		cp -rf bin/Magisk/Magisk!defaultMagisk!.apk tmp/system/system/data-app/Magisk/Magisk.apk
	) else (
		md tmp\product\data-app\Magisk
		cp -rf bin/Magisk/Magisk!defaultMagisk!.apk tmp/product/data-app/Magisk/Magisk.apk
	)
) else (
	!YELLOW! �Զ��Ʒ����޸�ROM
	!YELLOW! ��ROM��Ϊ��׿!androidVersion!
	if "!androidVersion!" LSS "13" (
		!CYAN! ���ھ���Ӧ��
		rm -rf tmp/vendor/data-app/*
		rm -rf tmp/product/data-app/*
		rm -rf tmp/system/system/app/MSA
		rm -rf tmp/system/system/app/mab
		rm -rf tmp/system/system/priv-app/MSA
		rm -rf tmp/system/system/priv-app/mab
		rm -rf tmp/system/system/app/Updater
		rm -rf tmp/system/system/app/MiuiUpdater
		rm -rf tmp/system/system/priv-app/Updater
		rm -rf tmp/system/system/priv-app/MiuiUpdater
		rm -rf tmp/system/system/app/*Hybrid*
		rm -rf tmp/system/system/app/AnalyticsCore/*
		rm -rf tmp/system/system/media/wallpaper/wallpaper_group/01*
		rm -rf tmp/system/system/media/wallpaper/wallpaper_group/02*
		rm -rf tmp/system/system/media/wallpaper/wallpaper_group/03*
		rm -rf tmp/system/system/media/wallpaper/wallpaper_group/04*
		rm -rf tmp/system/system/media/wallpaper/wallpaper_group/05*
		rm -rf tmp/system/system/media/wallpaper/wallpaper_group/06*
		busybox mkdir tmp/APK
		mv tmp/system/system/data-app/*Weather* tmp/APK/ 1>nul 2>nul
		mv tmp/system/system/data-app/*Media* tmp/APK/ 1>nul 2>nul
		mv tmp/system/system/data-app/*SoundRecorder* tmp/APK/  1>nul 2>nul
		mv tmp/system/system/data-app/*ScreenRecorder* tmp/APK/ 1>nul 2>nul
		mv tmp/system/system/data-app/*Calculator* tmp/APK/ 1>nul 2>nul
		mv tmp/system/system/data-app/*GoogleContact* tmp/APK/  1>nul 2>nul
		rm -rf tmp/system/system/data-app/*
		cp -rf tmp/APK/* tmp/system/system/data-app
		rm -rf tmp/APK
		if exist tmp\system\system\app\AnalyticsCore cp bin/apks/AnalyticsCore.apk tmp/system/system/app/AnalyticsCore/AnalyticsCore.apk
	) else (
		!CYAN! ���ھ���Ӧ��
		rm -rf tmp/product/app/MSA
		rm -rf tmp/product/app/mab
		rm -rf tmp/system/system/app/MSA
		rm -rf tmp/system/system/app/mab
		rm -rf tmp/product/priv-app/MSA
		rm -rf tmp/system/system/priv-app/MSA
		rm -rf tmp/product/app/Updater
		rm -rf tmp/product/app/MiuiUpdater
		rm -rf tmp/product/priv-app/Updater
		rm -rf tmp/product/priv-app/MiuiUpdater
		rm -rf tmp/product/app/*Hybrid*
		rm -rf tmp/product/etc/auto-install*
		rm -rf tmp/product/app/AnalyticsCore/*
		rm -rf tmp/product/media/wallpaper/wallpaper_group/01*
		rm -rf tmp/product/media/wallpaper/wallpaper_group/02*
		rm -rf tmp/product/media/wallpaper/wallpaper_group/03*
		rm -rf tmp/product/media/wallpaper/wallpaper_group/04*
		rm -rf tmp/product/media/wallpaper/wallpaper_group/05*
		rm -rf tmp/product/media/wallpaper/wallpaper_group/06*
		busybox mkdir tmp/APK
		mv tmp/product/data-app/*Weather* tmp/APK/ 1>nul 2>nul
		mv tmp/product/data-app/*Media* tmp/APK/ 1>nul 2>nul
		mv tmp/product/data-app/*SoundRecorder* tmp/APK/  1>nul 2>nul
		mv tmp/product/data-app/*ScreenRecorder* tmp/APK/ 1>nul 2>nul
		mv tmp/product/data-app/*Calculator* tmp/APK/ 1>nul 2>nul
		mv tmp/product/data-app/*GoogleContact* tmp/APK/  1>nul 2>nul
		rm -rf tmp/product/data-app/*
		cp -rf tmp/APK/* tmp/product/data-app
		rm -rf tmp/APK
		if exist tmp\product\app\AnalyticsCore cp bin/apks/AnalyticsCore.apk tmp/product/app/AnalyticsCore/AnalyticsCore.apk
	)
	if exist tmp\product\media\theme\default cp -rf bin/puresky/com.android.settings.diy tmp/product/media/theme/default/com.android.settings
	if exist tmp\system\system\media\theme\default cp -rf bin/puresky/com.android.settings.diy tmp/system/system/media/theme/default/com.android.settings
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr custom_version_name') do (set mdfName=%%j)
	if "!mdfName!" neq "" (
		!CYAN! �����Զ���汾����
		7z x -y bin/puresky/diy.settings -otmp/version 1>nul 2>nul
		for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr custom_version_name ^|cut -d ":" -f 2 ^|cut -d "}" -f 1') do (set myDiyName=%%j)
		echo.[%time:~0,8%] !myDiyName! |iconv -f utf8 -t gbk
		sed -i "s/versionName/!myDiyName!/g" tmp/version/theme_values.xml
		sed -i "s/versionName/!myDiyName!/g" tmp/version/nightmode/theme_values.xml
		cd tmp\version\
		7z a -tzip com.android.settings ./ 1>nul 2>nul
		cd ..\..\
		if exist tmp\product\media\theme\default (
			cp -rf tmp/version/com.android.settings tmp/product/media/theme/default/com.android.settings 1>nul 2>nul
		)
		if exist tmp\system\system\media\theme\default (
			cp -rf tmp/version/com.android.settings tmp/system/system/media/theme/default/com.android.settings 1>nul 2>nul
		)
		rm -rf tmp/version
		set mdfName=
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr all_data_app') do (set rmAllData=%%j)
	if "!rmAllData!" == "{all_data_app}" (
		!CYAN! ����ɾ�����Կ�ж��Ԥװ��data-app��
		rm -rf tmp/vendor/data-app/*
		rm -rf tmp/product/data-app/*
		rm -rf tmp/system/system/data-app/*
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr unlock_theme') do (set unlock_theme=%%j)
	if "!unlock_theme!" == "{unlock_theme}" if "!deviceCode!" neq "ELISH" if "!deviceCode!" neq "NABU" if "!deviceCode!" neq "ENUMA" if "!deviceCode!" neq "DAGU"  if "!deviceCode!" neq "YUNLUO" (
		!CYAN! ������������ƽ�
		for /f "tokens=*" %%j in ('busybox find tmp/ -type f -name "*ThemeManager*.apk"') do (set ThemeManager=%%j)
		if "!androidVersion!" LSS "13" (
			cp -rf bin/apks/MIUIThemeManager.apk !ThemeManager!
		) else (
			REM bash bin/puresky/thememanager
			cp -rf bin/apks/MIUIThemeManager_T.apk !ThemeManager!
		)
		
		for /f "tokens=*" %%j in ('busybox find tmp/ -type f -name init.miui.rc') do (set MiuiInitRC=%%j)
		for /f "tokens=*" %%j in ('busybox find tmp/ -type f -name init.rc') do (set initRc=%%j)
		
		if "!MiuiInitRC!" neq "" (
			sed -i "/on boot/a\    chmod 0731 \/data\/system\/theme" !MiuiInitRC!
		)
		if "!MiuiInitRC!" equ "" if "!initRc!" neq "" (
			sed -i "/on boot/a\    chmod 0731 \/data\/system\/theme" !initRc!
		)
		
		
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr remove_data_encrypt') do (set remove_data_encrypt=%%j)
	if "!remove_data_encrypt!" == "{remove_data_encrypt}" (
		!CYAN! ����ȥ��Data����
		for /f "tokens=*" %%j in ('busybox find tmp/ -type f ^|findstr fstab ^|findstr /v "enableswap _"') do (
			set fstabfile=%%j
			echo.[%time:~0,8%] ������Ŀ���ļ���!fstabfile!
			sed -i "s/ro,/ro,noatime,/g" !fstabfile!
			sed -i "s/,avb_keys=\/avb\/q-gsi.avbpubkey:\/avb\/r-gsi.avbpubkey:\/avb\/s-gsi.avbpubkey:\/avb\/t-gsi.avbpubkey//g" !fstabfile!
			sed -i "s/,avb_keys=\/avb\/q-gsi.avbpubkey:\/avb\/r-gsi.avbpubkey:\/avb\/s-gsi.avbpubkey//g" !fstabfile!
			sed -i "s/,avb=vbmeta_system//g" !fstabfile!
			sed -i "s/,avb=vbmeta_vendor//g" !fstabfile!
			sed -i "s/,avb=vbmeta//g" !fstabfile!
			sed -i "s/,avb//g" !fstabfile!
			sed -i "s/,fileencryption=aes-256-xts:aes-256-cts:v2+inlinecrypt_optimized+wrappedkey_v0//g" !fstabfile!
			sed -i "s/,fileencryption=aes-256-xts:aes-256-cts:v2+emmc_optimized+wrappedkey_v0//g" !fstabfile!
			sed -i "s/,fileencryption=aes-256-xts:aes-256-cts:v2//g" !fstabfile!
			sed -i "s/,metadata_encryption=aes-256-xts:wrappedkey_v0//g" !fstabfile!
			sed -i "s/,fileencryption=aes-256-xts:wrappedkey_v0//g" !fstabfile!
			sed -i "s/,metadata_encryption=aes-256-xts//g" !fstabfile!
			sed -i "s/,fileencryption=aes-256-xts//g" !fstabfile!
			sed -i "s/,fileencryption=ice//g" !fstabfile!
			sed -i "s/fileencryption/encryptable/g" !fstabfile!
		)
	)

	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr erofs2ext4') do (set erofs2ext4=%%j)
	if "!erofs2ext4!" == "{erofs2ext4}" (
		!CYAN! EROFS�ļ�ϵͳתEXT4
		if exist !diyId!_log.log sed -i "s/erofs/ext4/g" !diyId!_log.log
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr ext42erofs') do (set ext42erofs=%%j)
	if "!ext42erofs!" == "{ext42erofs}" (
		!CYAN! EXT4�ļ�ϵͳתEROFS
		if exist !diyId!_log.log sed -i "s/ext4/erofs/g" !diyId!_log.log
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr motor') do (set motor=%%j)
	if "!motor!" == "{motor}" (
		!CYAN! �����޸��Ż����Ч��
		sed -i "s/sys.haptic.down.weak=.*/sys.haptic.down.weak=0/g" tmp/vendor/build.prop
		sed -i "s/sys.haptic.down.normal=.*/sys.haptic.down.normal=2/g" tmp/vendor/build.prop
		sed -i "s/sys.haptic.down.strong=.*/sys.haptic.down.strong=5/g" tmp/vendor/build.prop
		sed -i "s/sys.haptic.down=.*/sys.haptic.down=3,2/g" tmp/vendor/build.prop
		sed -i "s/sys.haptic.tap.normal=.*/sys.haptic.tap.normal=0,2/g" tmp/vendor/build.prop
		sed -i "s/sys.haptic.tap.light=.*/sys.haptic.tap.light=3,1/g" tmp/vendor/build.prop
		sed -i "s/sys.haptic.flick=.*/sys.haptic.flick=3,2/g" tmp/vendor/build.prop
		sed -i "s/sys.haptic.flick.light=.*/sys.haptic.flick.light=3,1/g" tmp/vendor/build.prop
		sed -i "s/sys.haptic.switch=.*/sys.haptic.switch=3,1/g" tmp/vendor/build.prop
		sed -i "s/sys.haptic.mesh.heavy=.*/sys.haptic.mesh.heavy=0,2/g" tmp/vendor/build.prop
		sed -i "s/sys.haptic.mesh.normal=.*/sys.haptic.mesh.normal=3,2/g" tmp/vendor/build.prop
		sed -i "s/sys.haptic.mesh.light=.*/sys.haptic.mesh.light=3,1/g" tmp/vendor/build.prop
		sed -i "s/sys.haptic.long.press=.*/sys.haptic.long.press=3,2/g" tmp/vendor/build.prop
		sed -i "s/sys.haptic.popup.normal=.*/sys.haptic.popup.normal=3,2/g" tmp/vendor/build.prop
		sed -i "s/sys.haptic.popup.light=.*/sys.haptic.popup.light=3,1/g" tmp/vendor/build.prop
		sed -i "s/sys.haptic.pickup=.*/sys.haptic.pickup=3,1/g" tmp/vendor/build.prop
		sed -i "s/sys.haptic.scroll.edge=.*/sys.haptic.scroll.edge=3,2/g" tmp/vendor/build.prop
		sed -i "s/sys.haptic.trigger.drawer=.*/sys.haptic.trigger.drawer=3,1/g" tmp/vendor/build.prop
		sed -i "s/sys.haptic.hold=.*/sys.haptic.hold=3,2/g" tmp/vendor/build.prop
		sed -i "s/sys.haptic.runin=.*/sys.haptic.runin=13/g" tmp/vendor/build.prop
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr magisk') do (set addMagisk=%%j)
	if "!addMagisk!" neq "" (
		for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr magisk ^|cut -d "k" -f 2 ^|cut -d "}" -f 1') do (set magiskVersion=%%j)
		if "!magiskVersion!" == "" set magiskVersion=26100
		!CYAN! ���Magisk-ROOT���汾:!magiskVersion!
		7z x -y bin/Magisk/Magisk!magiskVersion!.apk -otmp/magisk 1>nul 2>nul
		for /f "tokens=*" %%i in ('dir /b /s tmp\magisk ^|findstr arm ^|findstr magisk32') do (set magisk32File=%%i)
		for /f "tokens=*" %%i in ('dir /b /s tmp\magisk ^|findstr arm ^|findstr magisk64') do (set magisk64File=%%i)
		for /f "tokens=*" %%i in ('dir /b /s tmp\magisk ^|findstr arm64 ^|findstr magiskinit') do (set magiskInitFile=%%i)
		if "!magiskInitFile!" equ "" for /f "tokens=*" %%i in ('dir /b /s tmp\magisk ^|findstr arm ^|findstr magiskinit') do (set magiskInitFile=%%i)
		echo.[%time:~0,8%] magisk32 �ļ���!magisk32File!
		echo.[%time:~0,8%] magisk64 �ļ���!magisk64File!
		echo.[%time:~0,8%] magiskinit �ļ���!magiskInitFile!
		
		move tmp\magisk\assets\util_functions.sh !CD!\util_functions.sh 1>nul 2>nul
		move !magisk32File! !CD!\magisk32 1>nul 2>nul
		move !magisk64File! !CD!\magisk64 1>nul 2>nul
		move !magiskInitFile! !CD!\magiskinit 1>nul 2>nul
		if exist tmp\magisk\assets\stub.apk move tmp\magisk\assets\stub.apk !CD!\stub.apk 1>nul 2>nul
		bash bin/puresky/boot_patch.sh tmp/boot.img
		move new-boot.img tmp\output\boot_magisk.img 1>nul 2>nul
		move tmp\boot.img tmp\output\boot_official.img 1>nul 2>nul
		
		7z x -y bin\ramdisk\ramdisk.zip !androidVersion!-!deviceCode!-ramdisk.cpio -otmp 1>nul 2>nul
		if exist tmp\!androidVersion!-!deviceCode!-ramdisk.cpio (
			!CYAN! ���ںϲ�TWRP
			magiskboot unpack tmp/output/boot_official.img 1>nul 2>nul
			cp -rf tmp/!androidVersion!-!deviceCode!-ramdisk.cpio ramdisk.cpio
			rm tmp/!androidVersion!-!deviceCode!-ramdisk.cpio
			magiskboot repack tmp/output/boot_official.img 1>nul 2>nul
			mv new-boot.img twrp.img
			bash bin/puresky/boot_patch.sh twrp.img
			rm twrp.img
			mv new-boot.img tmp/output/boot_twrp.img
		)
		if exist tmp\init_boot.img (
			bash bin/puresky/boot_patch.sh tmp/init_boot.img
			move new-boot.img tmp\output\init_boot_magisk.img 1>nul 2>nul
			move tmp\init_boot.img tmp\output\init_boot_official.img 1>nul 2>nul
		)
		rm -rf tmp/magisk util_functions.sh
		rm -rf magisk32 magisk64 magiskinit stub.apk
		set addMagisk=
		if exist tmp\system\system\data-app (
			md tmp\system\system\data-app\Magisk
			cp -rf bin/Magisk/Magisk!magiskVersion!.apk tmp/system/system/data-app/Magisk/Magisk.apk
		) else (
			md tmp\product\data-app\Magisk
			cp -rf bin/Magisk/Magisk!magiskVersion!.apk tmp/product/data-app/Magisk/Magisk.apk
		)
	) else (
		mv tmp/boot.img tmp/output/boot_official.img
		if exist bin\ramdisk\!androidVersion!-!deviceCode!-ramdisk.cpio (
			!CYAN! ���ںϲ�TWRP
			magiskboot unpack tmp/output/boot_official.img 1>nul 2>nul
			cp -rf bin/ramdisk/!androidVersion!-!deviceCode!-ramdisk.cpio ramdisk.cpio
			magiskboot repack tmp/output/boot_official.img 1>nul 2>nul
			mv new-boot.img tmp/output/boot_twrp.img
		)
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr autoinstall') do (set autoinstall=%%j)
	if "!autoinstall!" == "{autoinstall}" (
		!CYAN! ����ȥ������ϵͳӦ�ø�����ʾ
		rm -rf tmp/product/etc/auto-install*
		rm -rf tmp/system/system/etc/auto-install*
	)
	call :SUBMITPROGRESS 53 �޸�
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr dcbacklight') do (set dcbacklight=%%j)
	if "!dcbacklight!" == "{dcbacklight}" (
		!CYAN! ���ڳ������DC����
		for /f "tokens=*" %%j in ('busybox find tmp/ -type d ^|findstr device_features ^|awk NR^=^=1') do (set deviceFeature=%%j)
		sed -i "s/<bool name=\"dc_backlight_fps_incompatible\">true<\/bool>/<bool name=\"dc_backlight_fps_incompatible\">false<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_dc_backlight\">false<\/bool>/<bool name=\"support_dc_backlight\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_secret_dc_backlight\">true<\/bool>/<bool name=\"support_secret_dc_backlight\">false<\/bool>/" !deviceFeature!/*.xml
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr hosts') do (set hosts=%%j)
	if "!hosts!" == "{hosts}" (
		!CYAN! �������hostsȥ��棬����ܻᵼ�²���Ӧ���쳣
		if exist tmp\product\etc\hosts cp -rf bin/puresky/hosts tmp/product/etc/hosts
		if exist tmp\system\system\etc\hosts cp -rf bin/puresky/hosts tmp/system/system/etc/hosts
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr allhighrate') do (set allhighrate=%%j)
	if "!allhighrate!" == "{allhighrate}" (
		!CYAN! �����޸�ȫ�ָ�ˢ����֧�ָ�ˢ������Ч�Ұ�׿13������90Hz��ͻ��
		bash bin/puresky/mkpk |sed "s/^/[%time:~0,8%] &/g"
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr speed') do (set speed=%%j)
	if "!speed!" neq "" (
		!CYAN! �����޸�����ˢ����
		for /f "tokens=*" %%i in ('type bin\diy.psky ^|findstr speed') do (set modifyNetSpeed=%%i)
		if "!modifyNetSpeed!" == "{speedofive}" bash bin/puresky/mkui 0x1f4 |sed "s/^/[%time:~0,8%] &/g"
		if "!modifyNetSpeed!" == "{speedone}" bash bin/puresky/mkui 0x3e8 |sed "s/^/[%time:~0,8%] &/g"
		if "!modifyNetSpeed!" == "{speedtwo}" bash bin/puresky/mkui 0x7d0 |sed "s/^/[%time:~0,8%] &/g"
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr camera_optimize') do (set camera_optimize=%%j)
	if "!camera_optimize!" == "{camera_optimize}" (
		!CYAN! ���ڿ���������ز���
		for /f "tokens=*" %%j in ('busybox find tmp/ -type d ^|findstr device_features ^|awk NR^=^=1') do (set deviceFeature=%%j)
		sed -i "s/<bool name=\"is_support_portrait\">false<\/bool>/<bool name=\"is_support_portrait\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_front_hdr\">false<\/bool>/<bool name=\"support_front_hdr\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_front_hht\">false<\/bool>/<bool name=\"support_front_hht\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_front_bokeh\">false<\/bool>/<bool name=\"support_front_bokeh\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"is_support_optical_zoom\">false<\/bool>/<bool name=\"is_support_optical_zoom\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"is_legacy_face_beauty\">false<\/bool>/<bool name=\"is_legacy_face_beauty\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_picture_watermark\">false<\/bool>/<bool name=\"support_picture_watermark\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_front_beauty_mfnr\">false<\/bool>/<bool name=\"support_front_beauty_mfnr\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"camera_is_support_portrait_front\">false<\/bool>/<bool name=\"camera_is_support_portrait_front\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_3d_face_beauty\">false<\/bool>/<bool name=\"support_3d_face_beauty\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_video_hfr_mode\">false<\/bool>/<bool name=\"support_video_hfr_mode\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_super_resolution\">false<\/bool>/<bool name=\"support_super_resolution\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_front_flash\">false<\/bool>/<bool name=\"support_front_flash\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_realtime_manual_exposure_time\">false<\/bool>/<bool name=\"support_realtime_manual_exposure_time\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_camera_burst_shoot\">false<\/bool>/<bool name=\"support_camera_burst_shoot\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_camera_movie_solid\">false<\/bool>/<bool name=\"support_camera_movie_solid\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_camera_shader_effect\">false<\/bool>/<bool name=\"support_camera_shader_effect\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_camera_skin_beauty\">false<\/bool>/<bool name=\"support_camera_skin_beauty\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_camera_age_detection\">false<\/bool>/<bool name=\"support_camera_age_detection\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_camera_record_location\">false<\/bool>/<bool name=\"support_camera_record_location\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_camera_water_mark\">false<\/bool>/<bool name=\"support_camera_water_mark\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_camera_new_style_time_water_mark\">false<\/bool>/<bool name=\"support_camera_new_style_time_water_mark\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_camera_face_info_water_mark\">false<\/bool>/<bool name=\"support_camera_face_info_water_mark\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_camera_square_mode\">false<\/bool>/<bool name=\"support_camera_square_mode\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_camera_video_pause\">false<\/bool>/<bool name=\"support_camera_video_pause\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_camera_boost_brightness\">false<\/bool>/<bool name=\"support_camera_boost_brightness\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_camera_dynamic_light_spot\">false<\/bool>/<bool name=\"support_camera_dynamic_light_spot\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_full_size_panorama\">false<\/bool>/<bool name=\"support_full_size_panorama\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_camera_aohdr\">false<\/bool>/<bool name=\"support_camera_aohdr\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_camera_hfr\">false<\/bool>/<bool name=\"support_camera_hfr\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_chroma_flash\">false<\/bool>/<bool name=\"support_chroma_flash\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_android_flashlight\">false<\/bool>/<bool name=\"support_android_flashlight\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_object_track\">false<\/bool>/<bool name=\"support_object_track\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_camera_4k_quality\">false<\/bool>/<bool name=\"support_camera_4k_quality\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_camera_audio_focus\">false<\/bool>/<bool name=\"support_camera_audio_focus\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_camera_manual_function\">false<\/bool>/<bool name=\"support_camera_manual_function\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_camera_press_down_capture\">false<\/bool>/<bool name=\"support_camera_press_down_capture\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_camera_torch_capture\">false<\/bool>/<bool name=\"support_camera_torch_capture\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_camera_peaking_mf\">false<\/bool>/<bool name=\"support_camera_peaking_mf\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_hfr_video_pause\">false<\/bool>/<bool name=\"support_hfr_video_pause\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_camera_gradienter\">false<\/bool>/<bool name=\"support_camera_gradienter\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_camera_tilt_shift\">false<\/bool>/<bool name=\"support_camera_tilt_shift\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_camera_magic_mirror\">false<\/bool>/<bool name=\"support_camera_magic_mirror\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_camera_groupshot\">false<\/bool>/<bool name=\"support_camera_groupshot\">true<\/bool>/" !deviceFeature!/*.xml
		sed -i "s/<bool name=\"support_camera_quick_snap\">false<\/bool>/<bool name=\"support_camera_quick_snap\">true<\/bool>/" !deviceFeature!/*.xml
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr oldinstaller') do (set oldinstaller=%%j)
	if "!oldinstaller!" == "{oldinstaller}" (
		for /f "tokens=*" %%i in ('busybox find tmp/ -type f -name "M*PackageInstaller.apk"') do (set apkInstaller=%%i)
		!CYAN! �����滻�ɰ氲װ�� !apkInstaller!
		if "!androidVersion!" LSS "13" (
			if "!apkInstaller!" neq "" (
				echo.[%time:~0,8%] Ŀ���ļ���!apkInstaller!
				cp -rf bin/apks/MiuiPackageInstaller.apk !apkInstaller!
			)
		) else (
			!YELLOW! �ɰ氲װ���ڰ�׿13���޷�������ȥ��������
			cp -rf bin/apks/MIUIPackageInstaller_T.apk !apkInstaller!
		)
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr refreshrate') do (set refreshrate=%%j)
	if "!refreshrate!" == "{refreshrate}" (
		!CYAN! ���90Hzˢ���ʿ��أ���ѡ����ȫ�ָ�ˢ��ͻ��
		for /f "tokens=*" %%j in ('busybox find tmp/ -type d ^|findstr device_features ^|awk NR^=^=1') do (set deviceFeature=%%j)
		sed -i "/<item>120<\/item>/a\\t\t<item>90<\/item>" !deviceFeature!/*.xml
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr thermal') do (set thermal=%%j)
	if "!thermal!" == "{thermal}" (
		!CYAN! ����ȥ���¿ز���������ļ�
		for /f "tokens=*" %%j in ('busybox find tmp/vendor/bin tmp/vendor/etc -maxdepth 1 -type f -name "*thermal*" ^|sed "s/\//\\/g"') do (
			set thermalFile=%%j
			echo.>!thermalFile!
			
		)
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr analytic') do (set analytic=%%j)
	if "!analytic!" == "{analytic}" (
		!CYAN! ����ȥ�� AnalyticsCore ����
		for /f "tokens=*" %%j in ('busybox find tmp/ -type f -name "AnalyticsCore.apk"') do (set atFile=%%j)
		if "!atFile!" neq "" cp -rf bin/apks/AnalyticsCore.apk !atFile!
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr powermode') do (set powermode=%%j)
	if "!powermode!" == "{powermode}" (
		!CYAN! �����������ģʽ
		sed -i "$a\persist.sys.power.default.powermode=1" tmp/system/system/build.prop
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr extram') do (set extram=%%j)
	if "!extram!" == "{extram}" (
		!CYAN! ��������ڴ���չ
		sed -i "$a\persist.miui.extm.enable=1" tmp/system/system/build.prop
		sed -i "$a\persist.miui.extm.bdsize=4096" tmp/system/system/build.prop
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr pignose') do (set pignose=%%j)
	if "!pignose!" == "{pignose}" (
		!CYAN! �������K30ϵ����ǣ��������Ϳ�����ȥ�ڿף�
		if exist tmp\vendor\overlay\DevicesOverlay.apk cp -rf bin/apks/DevicesOverlay.apk tmp/vendor/overlay/DevicesOverlay.apk
		if exist tmp\product\overlay\DevicesOverlay.apk cp -rf bin/apks/DevicesOverlay.apk tmp/product/overlay/DevicesOverlay.apk
		if exist tmp\system_ext\overlay\DevicesOverlay.apk cp -rf bin/apks/DevicesOverlay.apk tmp/system_ext/overlay/DevicesOverlay.apk
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr hdhide') do (set hdhide=%%j)
	if "!hdhide!" == "{hdhide}" (
		!CYAN! ����������ؾɰ�״̬����HD
		if exist tmp\product\media\theme\default cp -rf bin/puresky/com.android.systemui.hidevolte tmp/product/media/theme/default/com.android.systemui
		if exist tmp\system\system\media\theme\default cp -rf bin/puresky/com.android.systemui.hidevolte tmp/system/system/media/theme/default/com.android.systemui
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr remove_logo') do (set remove_logo=%%j)
	if "!remove_logo!" == "{remove_logo}" (
		!CYAN! �ָ��ٷ��ҵ��豸��Ϣ
		rm -rf tmp/product/media/theme/default/com.android.settings
		rm -rf tmp/system/system/media/theme/default/com.android.settings
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr add_busybox') do (set add_busybox=%%i)
	if "!add_busybox!" == "{add_busybox}" (
		!CYAN! �������Busyboxָ�
		cp -rf bin/puresky/busybox tmp/system/system/bin/busybox
		echo.>>tmp\config\system_fs_config
		echo.>>tmp\config\system_file_contexts
		for /f "tokens=*" %%i in ('cat bin/puresky/busybox.txt') do (
			set bbcmd=%%i
			if not exist tmp\system\system\bin\!bbcmd! (
				ln -s tmp/system/system/bin/busybox tmp/system/system/bin/!bbcmd!
				echo./system/system/bin/!bbcmd! u:object_r:system_file:s0>>tmp\config\system_file_contexts
				echo.system/system/bin/!bbcmd! 0 0 0755>>tmp\config\system_fs_config
			)
		)
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr google') do (set google=%%j)
	if "!google!" == "{google}" (
		!CYAN! ����ȥ���ȸ������
		rm -rf tmp/product/priv-app/*GmsCore*
		rm -rf tmp/product/priv-app/*Phonesky*
		rm -rf tmp/product/priv-app/*ConfigUpdater*
		rm -rf tmp/product/priv-app/*GoogleService*
		rm -rf tmp/product/priv-app/*GooglePlayServicesUpdater*
		rm -rf tmp/system/system/app/*GmsCore*
		rm -rf tmp/system/system/app/*Phonesky*
		rm -rf tmp/system/system/app/*ConfigUpdater*
		rm -rf tmp/system/system/app/*GoogleService*
		rm -rf tmp/system/system/app/*GooglePlayServicesUpdater*
		rm -rf tmp/system/system/priv-app/*GmsCore*
		rm -rf tmp/system/system/priv-app/*Phonesky*
		rm -rf tmp/system/system/priv-app/*ConfigUpdater*
		rm -rf tmp/system/system/priv-app/*GoogleService*
		rm -rf tmp/system/system/priv-app/*GooglePlayServicesUpdater*
		rm -rf tmp/system/product/priv-app/*GmsCore*
		rm -rf tmp/system/product/priv-app/*Phonesky*
		rm -rf tmp/system/product/priv-app/*ConfigUpdater*
		rm -rf tmp/system/product/priv-app/*GoogleService*
		rm -rf tmp/system/product/priv-app/*GooglePlayServicesUpdater*
		rm -rf tmp/system/system/product/priv-app/*GmsCore*
		rm -rf tmp/system/system/product/priv-app/*Phonesky*
		rm -rf tmp/system/system/product/priv-app/*ConfigUpdater*
		rm -rf tmp/system/system/product/priv-app/*GoogleService*
		rm -rf tmp/system/system/product/priv-app/*GooglePlayServicesUpdater*
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr xiaoai') do (set xiaoai=%%j)
	if "!xiaoai!" == "{xiaoai}" (
		!CYAN! ����ȥ��С��ͬѧ
		rm -rf tmp/product/app/*VoiceAssist*
		rm -rf tmp/product/app/*VoiceTrigger*
		rm -rf tmp/product/app/*AiAsstVision*
		rm -rf tmp/product/priv-app/*VoiceAssist*
		rm -rf tmp/product/priv-app/*VoiceTrigger*
		rm -rf tmp/product/priv-app/*AiAsstVision*
		rm -rf tmp/system/system/app/*VoiceAssist*
		rm -rf tmp/system/system/app/*VoiceTrigger*
		rm -rf tmp/system/system/app/*AiAsstVision*
		rm -rf tmp/system/system/priv-app/*VoiceAssist*
		rm -rf tmp/system/system/priv-app/*VoiceTrigger*
		rm -rf tmp/system/system/priv-app/*AiAsstVision*
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr bootani') do (set bootani=%%j)
	if "!bootani!" == "{bootani}" (
		!CYAN! ����ȥ����������
		rm -rf tmp/product/media/bootaudio.mp3
		rm -rf tmp/product/media/bootanimation.zip
		rm -rf tmp/system/system/media/bootaudio.mp3
		rm -rf tmp/system/system/media/bootanimation.zip
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr fiveg') do (set fiveg=%%j)
	if "!fiveg!" == "{fiveg}" (
		!CYAN! �������5G����
		if "!androidVersion!" equ "13" if exist tmp\product\data-app (
			cp -rf bin/apks/FiveGSwitcher tmp/product/data-app/
		)
		if "!androidVersion!" neq "13" (
			cp -rf bin/apks/FiveGSwitcher tmp/system/system/data-app/
		)
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr via') do (set via=%%j)
	if "!via!" == "{via}" (
		!CYAN! �������Via�����
		if "!androidVersion!" equ "13" if exist tmp\product\data-app (
			cp -rf bin/apks/ViaBrowser tmp/product/data-app/
		)
		if "!androidVersion!" neq "13" (
			cp -rf bin/apks/ViaBrowser tmp/system/system/data-app/
		)
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr stopapp') do (set stopapp=%%j)
	if "!stopapp!" == "{stopapp}" (
		!CYAN! �������С����
		if "!androidVersion!" equ "13" if exist tmp\product\data-app (
			cp -rf bin/apks/StopApp tmp/product/data-app/
		)
		if "!androidVersion!" neq "13" (
			cp -rf bin/apks/StopApp tmp/system/system/data-app/
		)
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr idmplus') do (set idmplus=%%j)
	if "!idmplus!" == "{idmplus}" (
		!CYAN! �������1DM������
		if "!androidVersion!" equ "13" if exist tmp\product\data-app (
			cp -rf bin/apks/1DMPlus tmp/product/data-app/
		)
		if "!androidVersion!" neq "13" (
			cp -rf bin/apks/1DMPlus tmp/system/system/data-app/
		)
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr fastapp') do (set fastapp=%%j)
	if "!fastapp!" == "{fastapp}" (
		!CYAN! ����ȥ����Ӧ��
		rm -rf tmp/product/app/HybridAccessory
		rm -rf tmp/product/app/HybridPlatform
		rm -rf tmp/product/priv-app/HybridAccessory
		rm -rf tmp/product/priv-app/HybridPlatform
		rm -rf tmp/system/system/app/HybridAccessory
		rm -rf tmp/system/system/app/HybridPlatform
		rm -rf tmp/system/system/priv-app/HybridAccessory
		rm -rf tmp/system/system/priv-app/HybridPlatform
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr accessibility') do (set accessibility=%%j)
	if "!accessibility!" == "{accessibility}" (
		!CYAN! ����ȥ�����ϰ�
		rm -rf tmp/product/app/*Accessibility
		rm -rf tmp/product/priv-app/*Accessibility
		rm -rf tmp/system/system/app/*Accessibility
		rm -rf tmp/system/system/priv-app/*Accessibility
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr bugreport') do (set bugreport=%%j)
	if "!bugreport!" == "{bugreport}" (
		!CYAN! ����ȥ���û�����
		rm -rf tmp/product/app/*BugReport*
		rm -rf tmp/product/priv-app/*BugReport*
		rm -rf tmp/system/system/app/*BugReport*
		rm -rf tmp/system/system/priv-app/*BugReport*
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr supermarket') do (set supermarket=%%j)
	if "!supermarket!" == "{supermarket}" (
		!CYAN! ����ȥ��Ӧ���̵�
		rm -rf tmp/product/app/*SuperMarket*
		rm -rf tmp/product/priv-app/*SuperMarket*
		rm -rf tmp/system/system/app/*SuperMarket*
		rm -rf tmp/system/system/priv-app/*SuperMarket*
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr updater') do (set updater=%%j)
	if "!updater!" == "{updater}" (
		!CYAN! ����ȥ��ϵͳ����
		rm -rf tmp/product/app/Updater
		rm -rf tmp/product/priv-app/Updater
		rm -rf tmp/system/system/app/Updater
		rm -rf tmp/system/system/priv-app/Updater
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr browser') do (set browser=%%j)
	if "!browser!" == "{browser}" (
		!CYAN! ����ȥ��С�������
		rm -rf tmp/product/app/*Browser*
		rm -rf tmp/product/priv-app/*Browser*
		rm -rf tmp/system/system/app/*Browser*
		rm -rf tmp/system/system/priv-app/*Browser*
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr miservice') do (set miservice=%%j)
	if "!miservice!" == "{miservice}" (
		!CYAN! ����ȥ�������뷴��
		rm -rf tmp/product/app/MIService
		rm -rf tmp/product/app/MiService
		rm -rf tmp/product/priv-app/MIService
		rm -rf tmp/product/priv-app/MiService
		rm -rf tmp/system/system/app/MiService
		rm -rf tmp/system/system/app/MIService
		rm -rf tmp/system/system/priv-app/MIService
		rm -rf tmp/system/system/priv-app/MiService
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr music') do (set music=%%j)
	if "!music!" == "{music}" (
		!CYAN! ����ȥ���Դ�����
		rm -rf tmp/product/app/*Music*
		rm -rf tmp/product/priv-app/*Music*
		rm -rf tmp/system/system/app/*Music*
		rm -rf tmp/system/system/priv-app/*Music*
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr personal') do (set personal=%%j)
	if "!personal!" == "{personal}" (
		!CYAN! ����ȥ����������
		rm -rf tmp/product/app/*PersonalAssistant*
		rm -rf tmp/product/priv-app/*PersonalAssistant*
		rm -rf tmp/system/system/app/*PersonalAssistant*
		rm -rf tmp/system/system/priv-app/*PersonalAssistant*
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr search') do (set search=%%j)
	if "!search!" == "{search}" (
		!CYAN! ����ȥ������
		rm -rf tmp/product/app/*QuickSearch*
		rm -rf tmp/product/priv-app/*QuickSearch*
		rm -rf tmp/system/system/app/*QuickSearch*
		rm -rf tmp/system/system/priv-app/*QuickSearch*
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr certinstaller') do (set certinstaller=%%j)
	if "!certinstaller!" == "{certinstaller}" (
		!CYAN! ����ȥ��֤�鰲װ��
		rm -rf tmp/product/app/Certinstaller
		rm -rf tmp/product/priv-app/CertInstaller
		rm -rf tmp/system/system/app/Certinstaller
		rm -rf tmp/system/system/priv-app/CertInstaller
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr macro') do (set macro=%%j)
	if "!macro!" == "{macro}" (
		!CYAN! ����ȥ���Զ�����
		rm -rf tmp/product/app/com.xiaomi.macro
		rm -rf tmp/product/priv-app/com.xiaomi.macro
		rm -rf tmp/system/system/app/com.xiaomi.macro
		rm -rf tmp/system/system/priv-app/com.xiaomi.macro
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr tsmclient') do (set tsmclient=%%j)
	if "!tsmclient!" == "{tsmclient}" (
		!CYAN! ����ȥ��С�����ܿ�
		rm -rf tmp/product/app/*TSMClient*
		rm -rf tmp/product/priv-app/*TSMClient*
		rm -rf tmp/system/system/app/*TSMClient*
		rm -rf tmp/system/system/priv-app/*TSMClient*
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr milink') do (set milink=%%j)
	if "!milink!" == "{milink}" (
		!CYAN! ����ȥ��Ͷ������
		rm -rf tmp/product/priv-app/MiLink
		rm -rf tmp/product/priv-app/MiLinkC*
		rm -rf tmp/product/priv-app/MILink
		rm -rf tmp/product/priv-app/MILinkC*
		rm -rf tmp/product/priv-app/MiPlayClient
		rm -rf tmp/product/priv-app/MIPlayClient
		rm -rf tmp/product/app/MiLink
		rm -rf tmp/product/app/MiLinkC*
		rm -rf tmp/product/app/MILink
		rm -rf tmp/product/app/MILinkC*
		rm -rf tmp/product/app/MiPlayClient
		rm -rf tmp/product/app/MIPlayClient
		rm -rf tmp/system/system/priv-app/MiLink
		rm -rf tmp/system/system/priv-app/MiLinkC*
		rm -rf tmp/system/system/priv-app/MILink
		rm -rf tmp/system/system/priv-app/MILinkC*
		rm -rf tmp/system/system/priv-app/MiPlayClient
		rm -rf tmp/system/system/priv-app/MIPlayClient
		rm -rf tmp/system/system/app/MiLink
		rm -rf tmp/system/system/app/MiLinkC*
		rm -rf tmp/system/system/app/MILink
		rm -rf tmp/system/system/app/MILinkC*
		rm -rf tmp/system/system/app/MiPlayClient
		rm -rf tmp/system/system/app/MIPlayClient
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr mipay') do (set mipay=%%j)
	if "!mipay!" == "{mipay}" (
		!CYAN! ����ȥ��С��Ǯ��
		rm -rf tmp/product/priv-app/*Mipay*
		rm -rf tmp/product/priv-app/*MIpay*
		rm -rf tmp/product/app/*MIpay*
		rm -rf tmp/product/app/*Mipay*
		rm -rf tmp/system/system/priv-app/*Mipay*
		rm -rf tmp/system/system/priv-app/*MIpay*
		rm -rf tmp/system/system/app/*MIpay*
		rm -rf tmp/system/system/app/*Mipay*
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr mivideo') do (set mivideo=%%j)
	if "!mivideo!" == "{mivideo}" (
		!CYAN! ����ȥ��С����Ƶ
		rm -rf tmp/system/system/app/*Video
		rm -rf tmp/system/system/priv-app/*Video
		rm -rf tmp/product/app/*Video
		rm -rf tmp/product/priv-app/*Video
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr weather') do (set weather=%%j)
	if "!weather!" == "{weather}" (
		!CYAN! ����ȥ������
		rm -rf tmp/vendor/app/*Weather
		rm -rf tmp/product/app/*Weather
		rm -rf tmp/system/system/app/*Weather
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr calculator') do (set calculator=%%j)
	if "!calculator!" == "{calculator}" (
		!CYAN! ����ȥ��������
		rm -rf tmp/vendor/data-app/*Calculator
		rm -rf tmp/product/data-app/*Calculator
		rm -rf tmp/system/system/data-app/*Calculator
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr luping') do (set luping=%%j)
	if "!luping!" == "{luping}" (
		!CYAN! ����ȥ����Ļ¼��
		rm -rf tmp/vendor/data-app/*ScreenRecorder*
		rm -rf tmp/product/data-app/*ScreenRecorder*
		rm -rf tmp/system/system/data-app/*ScreenRecorder*
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr luyin') do (set luyin=%%j)
	if "!luyin!" == "{luyin}" (
		!CYAN! ����ȥ��¼����
		rm -rf tmp/vendor/data-app/*SoundRecorder*
		rm -rf tmp/product/data-app/*SoundRecorder*
		rm -rf tmp/system/system/data-app/*SoundRecorder*
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr gameservice') do (set gameservice=%%j)
	if "!gameservice!" == "{gameservice}" (
		!CYAN! ����ȥ����Ϸ����
		rm -rf tmp/product/app/*GameService
		rm -rf tmp/product/app/*GameCenter*
		rm -rf tmp/product/priv-app/*GameService
		rm -rf tmp/product/priv-app/*GameCenter*
		rm -rf tmp/vendor/app/*GameService
		rm -rf tmp/system/system/app/*GameService
		rm -rf tmp/system/system/app/*GameCenter*
		rm -rf tmp/system/system/priv-app/*GameService
		rm -rf tmp/system/system/priv-app/*GameCenter*
		rm -rf tmp/system/system/data-app/*GameService
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr touchassistant') do (set touchassistant=%%j)
	if "!touchassistant!" == "{touchassistant}" (
		!CYAN! ����ȥ��������
		rm -rf tmp/product/app/*TouchAssistant*
		rm -rf tmp/product/priv-app/*TouchAssistant*
		rm -rf tmp/system/system/app/*TouchAssistant*
		rm -rf tmp/system/system/priv-app/*TouchAssistant*
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr mishare') do (set mishare=%%j)
	if "!mishare!" == "{mishare}" (
		!CYAN! ����ȥ��С�׻��������ܻᵼ��С�׻���ʧЧ��
		rm -rf tmp/product/app/*Share
		rm -rf tmp/product/priv-app/*Share
		rm -rf tmp/system/system/app/*Share
		rm -rf tmp/system/system/priv-app/*Share
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr miuiplus') do (set miuiplus=%%j)
	if "!miuiplus!" == "{miuiplus}" (
		!CYAN! ����ȥ��MIUI����
		rm -rf tmp/product/app/*Mirror
		rm -rf tmp/product/app/*MirrorSmart*
		rm -rf tmp/product/priv-app/*Mirror
		rm -rf tmp/product/priv-app/*MirrorSmart*
		rm -rf tmp/system/system/app/*Mirror
		rm -rf tmp/system/system/app/*MirrorSmart*
		rm -rf tmp/system/system/priv-app/*Mirror
		rm -rf tmp/system/system/priv-app/*MirrorSmart*
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr contentextension') do (set contentextension=%%j)
	if "!contentextension!" == "{contentextension}" (
		!CYAN! ����ȥ��������
		rm -rf tmp/product/app/*ContentExtension
		rm -rf tmp/product/priv-app/*ContentExtension
		rm -rf tmp/system/system/app/*ContentExtension
		rm -rf tmp/system/system/priv-app/*ContentExtension
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr yellowpage') do (set yellowpage=%%j)
	if "!yellowpage!" == "{yellowpage}" (
		!CYAN! ����ȥ����ҳ
		rm -rf tmp/product/priv-app/*YellowPage
		rm -rf tmp/product/app/*YellowPage
		rm -rf tmp/system/system/priv-app/*YellowPage
		rm -rf tmp/system/system/app/*YellowPage
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr htmlview') do (set htmlview=%%j)
	if "!htmlview!" == "{htmlview}" (
		!CYAN! ����ȥ��HTML�鿴����ɾ����׿12�����Ͽ��ܻᵼ�²�������
		rm -rf tmp/product/priv-app/HTMLViewer
		rm -rf tmp/product/app/HTMLViewer
		rm -rf tmp/system/system/priv-app/HTMLViewer
		rm -rf tmp/system/system/app/HTMLViewer
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr fixmode') do (set fixmode=%%j)
	if "!fixmode!" == "{fixmode}" (
		!CYAN! ����ȥ��ά��ģʽ
		rm -rf tmp/product/priv-app/*MaintenanceMode
		rm -rf tmp/product/app/*MaintenanceMode
		rm -rf tmp/system/system/priv-app/*MaintenanceMode
		rm -rf tmp/system/system/app/*MaintenanceMode
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr vpnsdk') do (set vpnsdk=%%j)
	if "!vpnsdk!" == "{vpnsdk}" (
		!CYAN! ����ȥ����Ϸ���ٷ���VPN�����
		rm -rf tmp/product/priv-app/*VpnSdkManager
		rm -rf tmp/product/app/*VpnSdkManager
		rm -rf tmp/system/system/priv-app/*VpnSdkManager
		rm -rf tmp/system/system/app/*VpnSdkManager
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr calendar') do (set calendar=%%j)
	if "!calendar!" == "{calendar}" (
		!CYAN! ����ȥ������
		rm -rf tmp/product/priv-app/*Calendar*
		rm -rf tmp/product/app/*Calendar*
		rm -rf tmp/system/system/priv-app/*Calendar*
		rm -rf tmp/system/system/app/*Calendar*
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr payment') do (set payment=%%j)
	if "!payment!" == "{payment}" (
		!CYAN! ����ȥ���ױ�֧��
		rm -rf tmp/product/app/*PaymentService*
		rm -rf tmp/product/priv-app/*PaymentService*
		rm -rf tmp/system/system/app/*PaymentService*
		rm -rf tmp/system/system/priv-app/*PaymentService*
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr nextpay') do (set nextpay=%%j)
	if "!nextpay!" == "{nextpay}" (
		!CYAN! ����ȥ��С��֧��
		rm -rf tmp/product/app/*NextPay
		rm -rf tmp/product/priv-app/*NextPay
		rm -rf tmp/system/system/app/*NextPay
		rm -rf tmp/system/system/priv-app/*NextPay
	)
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr audiomonitor') do (set audiomonitor=%%j)
	if "!audiomonitor!" == "{audiomonitor}" (
		!CYAN! ����ȥ��¼������
		rm -rf tmp/product/app/MiuiAudioMonitor
		rm -rf tmp/product/app/MIUIAudioMonitor
		rm -rf tmp/product/priv-app/MiuiAudioMonitor
		rm -rf tmp/product/priv-app/MIUIAudioMonitor
		rm -rf tmp/system/system/app/MiuiAudioMonitor
		rm -rf tmp/system/system/app/MIUIAudioMonitor
		rm -rf tmp/system/system/priv-app/MiuiAudioMonitor
		rm -rf tmp/system/system/priv-app/MIUIAudioMonitor
	)
	
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr joyose') do (set joyose=%%j)
	if "!joyose!" == "{joyose}" (
		!CYAN! ����ȥ��Joyose
		rm -rf tmp/product/app/Joyose
		rm -rf tmp/product/priv-app/Joyose
		rm -rf tmp/system/system/app/Joyose
		rm -rf tmp/system/system/priv-app/Joyose
	)
	
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr aiasst') do (set aiasst=%%j)
	if "!aiasst!" == "{aiasst}" (
		!CYAN! ����ȥ��С������
		rm -rf tmp/product/app/AiAsstVision*
		rm -rf tmp/product/priv-app/AiAsstVision*
		rm -rf tmp/system/system/app/AiAsstVision*
		rm -rf tmp/system/system/priv-app/AiAsstVision*
	)
	
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr carwith') do (set carwith=%%j)
	if "!carwith!" == "{carwith}" (
		!CYAN! ����ȥ��CarWith
		rm -rf tmp/product/app/CarWith
		rm -rf tmp/product/priv-app/CarWith
		rm -rf tmp/system/system/app/CarWith
		rm -rf tmp/system/system/priv-app/CarWith
	)
	
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr hybridaccessory') do (set hybridaccessory=%%j)
	if "!hybridaccessory!" == "{hybridaccessory}" (
		!CYAN! ����ȥ���ǻ�����
		rm -rf tmp/product/app/HybridAccessory
		rm -rf tmp/product/priv-app/HybridAccessory
		rm -rf tmp/system/system/app/HybridAccessory
		rm -rf tmp/system/system/priv-app/HybridAccessory
	)
	
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr mediaviewer') do (set mediaviewer=%%j)
	if "!mediaviewer!" == "{mediaviewer}" (
		!CYAN! ����ȥ��ý��鿴��
		rm -rf tmp/product/app/MediaViewer*
		rm -rf tmp/product/priv-app/MediaViewer*
		rm -rf tmp/system/system/app/MediaViewer*
		rm -rf tmp/system/system/priv-app/MediaViewer*
	)
	
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr aicall') do (set aicall=%%j)
	if "!aicall!" == "{aicall}" (
		!CYAN! ����ȥ��С��ͨ��
		rm -rf tmp/product/app/MIUIAiasstService
		rm -rf tmp/product/priv-app/AiasstService
		rm -rf tmp/product/app/AiasstService
		rm -rf tmp/product/priv-app/AiasstService
		rm -rf tmp/product/app/MiuiAiasstService
		rm -rf tmp/product/priv-app/MiuiAiasstService
		rm -rf tmp/system/system/app/AiasstService
		rm -rf tmp/system/system/priv-app/AiasstService
		rm -rf tmp/system/system/app/MiuiAiasstService
		rm -rf tmp/system/system/priv-app/MiuiAiasstService
		rm -rf tmp/system/system/app/MIUIAiasstService
		rm -rf tmp/system/system/priv-app/MIUIAiasstService
	)
	
	
	for /f "tokens=*" %%j in ('type bin\diy.psky ^|findstr greenguard') do (set greenguard=%%j)
	if "!greenguard!" == "{greenguard}" (
		!CYAN! ����ȥ�������ػ�
		rm -rf tmp/product/app/MIUIgreenguard
		rm -rf tmp/product/priv-app/MIUIgreenguard
		rm -rf tmp/product/app/greenguard
		rm -rf tmp/product/priv-app/greenguard
		rm -rf tmp/product/app/Greenguard
		rm -rf tmp/product/priv-app/Greenguard
		rm -rf tmp/system/system/app/MIUIgreenguard
		rm -rf tmp/system/system/priv-app/MIUIgreenguard
		rm -rf tmp/system/system/app/greenguard
		rm -rf tmp/system/system/priv-app/greenguard
		rm -rf tmp/system/system/app/Greenguard
		rm -rf tmp/system/system/priv-app/Greenguard
	)
)

:CHECKNET_SECOND
curl -sS "https://jk.511i.cn" 1>nul 2>nul
if not errorlevel 0 (
	!RED! ���������������,�����������
	!YELLOW! �����������
	pause>nul
	goto CHECKNET_SECOND
) else (
	!GREEN! �������ͨ��
)

for /f %%i in ('bash bin/puresky/getSuperSize.sh !deviceCode!') do (set superSize=%%i)
set pname=
set totalSize=0
for %%i in (!superList!) do (
	set pname=%%i
	set persize=
	if not exist tmp\!pname! if not exist tmp\output\!pname!.img (
		set persize=0
	)
	if exist tmp\!pname! (
		for /f "tokens=*" %%i in ('du -sb tmp/!pname! ^|tr -cd 0-9') do (set persize=%%i)
	)
	if exist tmp\output\!pname!.img (
		for /f "tokens=*" %%i in ('du -sb tmp/output/!pname!.img ^|tr -cd 0-9') do (set persize=%%i)
	)
	for /f "tokens=*" %%i in ('echo.!totalSize! + !persize! ^|bc') do (set totalSize=%%i)
)
for /f "tokens=2 delims==" %%i in ('type !diyId!_log.log ^|findstr "system_fs"') do (set fsType=%%i)
if "!fsType!" == "ext4" (
	for /f "tokens=*" %%i in ('echo.!totalSize! + 478150656 ^|bc') do (set totalSize=%%i)
)
!CYAN! �߼������ܴ�С��!totalSize!
bash -c "[ !totalSize! -gt !superSize! ] && return 1 ||return 0"
if "!errorlevel!" NEQ "0" (
	!RED! �߼������ܴ�С[!totalSize!]����!superSize!
	!YELLOW! ɾ������data-app
	rm -rf tmp/vendor/data-app/*
	rm -rf tmp/product/data-app/*
	rm -rf tmp/system/system/data-app/*
)
set pname=
set totalSize=0
for %%i in (!superList!) do (
	set pname=%%i
	set persize=
	if not exist tmp\!pname! if not exist tmp\output\!pname!.img (
		set persize=0
	)
	if exist tmp\!pname! (
		for /f "tokens=*" %%i in ('du -sb tmp/!pname! ^|tr -cd 0-9') do (set persize=%%i)
	)
	if exist tmp\output\!pname!.img (
		for /f "tokens=*" %%i in ('du -sb tmp/output/!pname!.img ^|tr -cd 0-9') do (set persize=%%i)
	)
	for /f "tokens=*" %%i in ('echo.!totalSize! + !persize! ^|bc') do (set totalSize=%%i)
)
for /f "tokens=2 delims==" %%i in ('type !diyId!_log.log ^|findstr "system_fs"') do (set fsType=%%i)
if "!fsType!" == "ext4" (
	for /f "tokens=*" %%i in ('echo.!totalSize! + 478150656 ^|bc') do (set totalSize=%%i)
)
bash -c "[ !totalSize! -gt !superSize! ] && return 1 ||return 0"
if "!errorlevel!" NEQ "0" (
	!RED! �߼������ܴ�С[!totalSize!]����!superSize!
	!YELLOW! ɾ��������
	!YELLOW! ɾ���������
	!YELLOW! ɾ�����û�����
	!YELLOW! ɾ���������뷴��
	!YELLOW! ɾ����BasicDreams
	!YELLOW! ɾ����AiAsstVision
	!YELLOW! ɾ����AnalyticsCore
	!YELLOW! ɾ����BookmarkProvider
	busybox find tmp/ -type d -name Browser |xargs rm -rf
	busybox find tmp/ -type d -name MiuiBrowser |xargs rm -rf
	busybox find tmp/ -type d -name MIUIBrowser |xargs rm -rf
	busybox find tmp/ -type d -name "*Music*" |xargs rm -rf
	busybox find tmp/ -type d -name BugReport |xargs rm -rf
	busybox find tmp/ -type d -name MiBugReport |xargs rm -rf
	busybox find tmp/ -type d -name MIBugReport |xargs rm -rf
	busybox find tmp/ -type d -name MiService |xargs rm -rf
	busybox find tmp/ -type d -name MIService |xargs rm -rf
	busybox find tmp/ -type d -name "*Music*" |xargs rm -rf
	busybox find tmp/ -type d -name BookmarkProvider |xargs rm -rf
	busybox find tmp/ -type d -name AnalyticsCore |xargs rm -rf
	busybox find tmp/ -type d -name BasicDreams |xargs rm -rf
	busybox find tmp/ -type d -name AiAsstVision |xargs rm -rf
)
set pname=
set totalSize=0
for %%i in (!superList!) do (
	set pname=%%i
	set persize=
	if not exist tmp\!pname! if not exist tmp\output\!pname!.img (
		set persize=0
	)
	if exist tmp\!pname! (
		for /f "tokens=*" %%i in ('du -sb tmp/!pname! ^|tr -cd 0-9') do (set persize=%%i)
	)
	if exist tmp\output\!pname!.img (
		for /f "tokens=*" %%i in ('du -sb tmp/output/!pname!.img ^|tr -cd 0-9') do (set persize=%%i)
	)
	for /f "tokens=*" %%i in ('echo.!totalSize! + !persize! ^|bc') do (set totalSize=%%i)
)
for /f "tokens=2 delims==" %%i in ('type !diyId!_log.log ^|findstr "system_fs"') do (set fsType=%%i)
if "!fsType!" == "ext4" (
	for /f "tokens=*" %%i in ('echo.!totalSize! + 478150656 ^|bc') do (set totalSize=%%i)
)
bash -c "[ !totalSize! -gt !superSize! ] && return 1 ||return 0"
if "!errorlevel!" NEQ "0" (
	!RED! �߼������ܴ�С[!totalSize!]����!superSize!
	!YELLOW! ɾ��������
	!YELLOW! ɾ������Ϸ����
	!YELLOW! ɾ����С�׻���
	!YELLOW! ɾ����С�����ϰ�
	!YELLOW! ɾ����С��Ӧ���̵�
	busybox find tmp/ -type d -name Accessibility |xargs rm -rf
	busybox find tmp/ -type d -name MiuiAccessibility |xargs rm -rf
	busybox find tmp/ -type d -name MIUIAccessibility |xargs rm -rf
	busybox find tmp/ -type d -name SuperMarket |xargs rm -rf
	busybox find tmp/ -type d -name MiuiSuperMarket |xargs rm -rf
	busybox find tmp/ -type d -name MIUISuperMarket |xargs rm -rf
	busybox find tmp/ -type d -name QuickSearchBox |xargs rm -rf
	busybox find tmp/ -type d -name MiuiQuickSearchBox |xargs rm -rf
	busybox find tmp/ -type d -name MIUIQuickSearchBox |xargs rm -rf
	busybox find tmp/ -type d -name MiGameCenterSDKService |xargs rm -rf
	busybox find tmp/ -type d -name GameCenterSDKService |xargs rm -rf
	busybox find tmp/ -type d -name MIGameCenterSDKService |xargs rm -rf
	busybox find tmp/ -type d -name MIShare |xargs rm -rf
	busybox find tmp/ -type d -name MiShare |xargs rm -rf
)

call :SUBMITPROGRESS 67 ���
for %%i in (!superList!) do (
	set pname=%%i
	if exist tmp\!pname! (
		for /f "tokens=2 delims==" %%i in ('type !diyId!_log.log ^|findstr "!pname!_fs"') do (set fsType=%%i)
		if "!fsType!" == "erofs" (
			call :MAKE_EROFS_IMG !pname!
		) else (
			call :MAKE_EXT4_IMG !pname!
		)
		rd /s /q \\?\!CD!\tmp\!pname! 1>nul 2>nul
		del /s /q \\?\!CD!\tmp\!pname! 1>nul 2>nul
	)
)


call :SUBMITPROGRESS 78 ����


REM ��� super

!YELLOW! ����ˢ����ʽ����ˢ����
if "!flashType!" NEQ "Recovery" (
	if "!superSize!" == "" set superSize=9126805504
	set size=
	if "!deviceArch!" == "VAB" set lpargs= -F --virtual-ab --output tmp/output/super.img --metadata-size 65536 --super-name super --metadata-slots 3 --device super:!superSize! --group=qti_dynamic_partitions_a:!superSize! --group=qti_dynamic_partitions_b:!superSize!
	if "!deviceArch!" == "AonlyDynamic" set lpargs= -F --output tmp/output/super.img --metadata-size 65536 --super-name super --metadata-slots 3 --device super:!superSize! --group=qti_dynamic_partitions:!superSize!
	for %%i in (!superList!) do (
		set pname=%%i
		if "!deviceArch!" == "VAB" (
			if exist tmp\output\!pname!.img (
				for /f %%i in ('du -sb tmp/output/!pname!.img ^|tr -cd 0-9') do (set size=%%i)
				!GREEN! SUPER�Ӿ��� [!pname!.img] ��С [!size!]
				set args=--partition !pname!_a:none:!size!:qti_dynamic_partitions_a --image !pname!_a=tmp/output/!pname!.img --partition !pname!_b:none:0:qti_dynamic_partitions_b
				echo.[%time:~0,8%] args^+=--partition !pname!_a:none:!size!:qti_dynamic_partitions_a --image !pname!_a=tmp/output/!pname!.img --partition !pname!_b:none:0:qti_dynamic_partitions_b>>!diyId!_log.log
				set lpargs=!lpargs! !args!
			)
		) else (
			if exist tmp\output\!pname!.img (
				for /f %%i in ('du -sb tmp/output/!pname!.img ^|tr -cd 0-9') do (set size=%%i)
				!GREEN! SUPER�Ӿ��� [!pname!.img] ��С [!size!]
				set args=--partition !pname!:none:!size!:qti_dynamic_partitions --image !pname!=tmp/output/!pname!.img
				echo.[%time:~0,8%] args^+=--partition !pname!:none:!size!:qti_dynamic_partitions --image !pname!=tmp/output/!pname!.img>>!diyId!_log.log
				set lpargs=!lpargs! !args!
			)
		)
	)
	!CYAN! ���ڴ�� super.img
	lpmake !lpargs!
	if exist tmp\output\super.img (
		!GREEN! �ɹ���� super.img
	) else (
		echo.
		!RED! ��� super.img ʱ���ִ���
		echo.
		pause
		exit
	)
)


REM ����ˢ����ʽ����ˢ����
if "!flashType!" == "Recovery" (
	!GREEN! �˻��ʹ����ֻ�����Recovery��ˢ��
	!CYAN! ���������ļ�...
	if exist tmp\output\boot_official.img move tmp\output\boot_official.img tmp\boot.img 1>nul 2>nul
	if exist tmp\output\boot_magisk.img mv -f tmp/output/boot_magisk.img tmp/boot.img
	del tmp\output\boot_*.img 1>nul 2>nul
	if exist tmp\dynamic_partitions_op_list (
		echo.[%time:~0,8%] ��̬�������ͣ�!deviceCode! - !deviceName!>>!diyId!_log.log
		sed -i "/resize/d" tmp/dynamic_partitions_op_list
		sed -i "/# Grow/d" tmp/dynamic_partitions_op_list
		for %%i in (!superList!) do (
			set pname=%%i
			if exist tmp\output\!pname!.img (
				for /f %%j in ('type !diyId!_log.log ^|findstr !pname!_size ^|cut -d "=" -f 2') do (set size=%%j)
				echo.# Grow partition !pname! from 0 to !size!>>tmp\dynamic_partitions_op_list
				echo.resize !pname! !size!>>tmp\dynamic_partitions_op_list
				echo.[%time:~0,8%] # Grow partition !pname! from 0 to !size!>>!diyId!_log.log
				echo.[%time:~0,8%] resize !pname! !size!>>!diyId!_log.log
			)
		)
		dos2unix tmp/dynamic_partitions_op_list
	)
	for %%i in (!superList!) do (
		set pname=%%i
		if exist tmp\output\!pname!.img (
			!CYAN! �������� !pname!.new.dat.br
			img2simg tmp/output/!pname!.img tmp/!pname!.img
			img2sdat tmp/!pname!.img -v 4 -p !pname! -o tmp 1>nul 2>nul
			brotli -j -q 5 tmp/!pname!.new.dat -o tmp/!pname!.new.dat.br
			rm -rf tmp/!pname!.new.dat
			rm -rf tmp/output/!pname!.img
			rm -rf tmp/!pname!.img
		)
	)
)


if "!flashType!" == "Fastboot" (
	!GREEN! �˻��ʹ����ֻ�����Fastboot��ˢ��
	!CYAN! ���������ļ�...
	cp -rf bin/flash/* tmp/
	cp -rf bin/platform-tools/* tmp/bin/
	rd /s /q tmp\bin\android 1>nul 2>nul
	!CYAN! Super raw image ת��Ϊ Super sparse image...
	img2simg tmp/output/super.img tmp/images/super.img
	move tmp\output\boot_official.img tmp\images\boot_official.img 1>nul 2>nul
	move tmp\output\boot_magisk.img tmp\images\boot_magisk.img 1>nul 2>nul
	if exist tmp\output\init_boot_magisk.img move tmp\output\init_boot_magisk.img tmp\images\init_boot_magisk.img 1>nul 2>nul
	if exist tmp\output\init_boot_official.img move tmp\output\init_boot_official.img tmp\images\init_boot_official.img 1>nul 2>nul
	img2simg bin/images/cust.img tmp/images/cust.img
	!CYAN! ���ڸ��ݾ�������ˢ���ű�
	for /f "tokens=1 delims=." %%i in ('dir /b tmp\images ^|findstr -v "preload super boot_ recovery_ cust"') do (
		set fwimg=%%i
		echo.[%time:~0,8%] ��ӵ�ˢ���ű�: !fwimg!.img
		sed -i "/#HereToInsert/i \$bin\/fastboot flash !fwimg!_b images\/!fwimg!.img" tmp/PureSkyFlashUnix.sh
		sed -i "/#HereToInsert/i \$bin\/fastboot flash !fwimg!_a images\/!fwimg!.img" tmp/PureSkyFlashUnix.sh
		sed -i "/rem/i fastboot flash !fwimg!_b images\/!fwimg!.img" tmp/PureSkyFlashWindows.bat
		sed -i "/rem/i fastboot flash !fwimg!_a images\/!fwimg!.img" tmp/PureSkyFlashWindows.bat
	)
	dos2unix tmp/PureSkyFlashUnix.sh
	unix2dos tmp/PureSkyFlashWindows.bat
)

if "!flashType!" == "TwoInOne" (
	!GREEN! �˻��ʹ�����������ˢ��ˢ����һ��
	!CYAN! ���������ļ�...
	if exist tmp\firmware-update move tmp\firmware-update tmp\images 1>nul 2>nul
	move tmp\output\boot_official.img tmp\images\boot_official.img 1>nul 2>nul
	move tmp\output\boot_magisk.img tmp\images\boot_magisk.img 1>nul 2>nul
	move tmp\output\boot_twrp.img tmp\images\boot_twrp.img 1>nul 2>nul
	if exist tmp\output\init_boot_magisk.img move tmp\output\init_boot_magisk.img tmp\images\init_boot_magisk.img 1>nul 2>nul
	if exist tmp\output\init_boot_official.img move tmp\output\init_boot_official.img tmp\images\init_boot_official.img 1>nul 2>nul
	!CYAN! ����ѹ�� super.img...
	zstd --rm tmp\output\super.img -o tmp\images\super.img.zst
	cp -rf bin/flash/* tmp/
	cp -rf bin/images/cust.img tmp/images/cust.img
	if not exist tmp\META-INF md tmp\META-INF\com\google\android 1>nul 2>nul
	cp -rf bin/platform-tools/* tmp/bin/
	cp -rf bin/puresky/update-binary tmp/META-INF/com/google/android/update-binary 1>nul 2>nul
	if exist tmp\dynamic_partitions_op_list (
		!CYAN! ���ڸ���ԭˢ���ű������µ�ˢ���ű�...
		rd /s /q tmp\META-INF\com\android
		del tmp\dynamic_partitions_op_list
		move tmp\META-INF\com\google\android\updater-script tmp\updater-script 1>nul 2>nul
		for /f %%i in ('bash bin/puresky/getName') do (
			set script=%%i
			for /f "tokens=1 delims==" %%j in ('echo.!script! ^|sed "s/ //g"') do (set fname=%%j)
			for /f "tokens=2 delims==" %%k in ('echo.!script! ^|sed "s/ //g"') do (set pname=%%k)
			echo.[%time:~0,8%] ���ˢ���ű���!fname! -^> !pname!
			sed -i "/#HereToInsert/a \$bin\/fastboot flash !pname! images\/!fname!" tmp/PureSkyFlashUnix.sh
			sed -i "/rem/a fastboot flash !pname! images\/!fname!" tmp/PureSkyFlashWindows.bat
			sed -i "/#firmware/a package_extract_file \"images/!fname!\" \"/dev/block/bootdevice/by-name/!pname!\"" tmp/META-INF/com/google/android/update-binary
		)
		del tmp\updater-script
		sed -i "s/init_boot/initboot/g" tmp/PureSkyFlashUnix.sh
		sed -i "s/init_boot/initboot/g" tmp/PureSkyFlashWindows.bat
		sed -i "s/init_boot/initboot/g" tmp/META-INF/com/google/android/update-binary
		sed -i "/set_active/d" tmp/PureSkyFlashUnix.sh
		sed -i "/set_active/d" tmp/PureSkyFlashWindows.bat
		sed -i "/_b/d" tmp/PureSkyFlashUnix.sh
		sed -i "/_b/d" tmp/PureSkyFlashWindows.bat
		sed -i "/_b/d" tmp/META-INF/com/google/android/update-binary
		sed -i "s/_a//g" tmp/PureSkyFlashUnix.sh
		sed -i "s/_a//g" tmp/PureSkyFlashWindows.bat
		sed -i "s/_a//g" tmp/META-INF/com/google/android/update-binary
		sed -i "s/initboot/init_boot/g" tmp/PureSkyFlashUnix.sh
		sed -i "s/initboot/init_boot/g" tmp/PureSkyFlashWindows.bat
		sed -i "s/initboot/init_boot/g" tmp/META-INF/com/google/android/update-binary
	) else (
		!CYAN! ���ڸ��ݾ�������ˢ���ű�
		for /f "tokens=1 delims=." %%i in ('dir /b tmp\images ^|findstr -v "preload super boot_ recovery_ cust"') do (
			set fwimg=%%i
			echo.[%time:~0,8%] ��ӵ�ˢ���ű�: !fwimg!.img
			sed -i "/#HereToInsert/i \$bin\/fastboot flash !fwimg!_b images\/!fwimg!.img" tmp/PureSkyFlashUnix.sh
			sed -i "/#HereToInsert/i \$bin\/fastboot flash !fwimg!_a images\/!fwimg!.img" tmp/PureSkyFlashUnix.sh
			sed -i "/rem/i fastboot flash !fwimg!_b images\/!fwimg!.img" tmp/PureSkyFlashWindows.bat
			sed -i "/rem/i fastboot flash !fwimg!_a images\/!fwimg!.img" tmp/PureSkyFlashWindows.bat
			sed -i "/#firmware/i package_extract_file \"images/!fwimg!.img\" \"/dev/block/bootdevice/by-name/!fwimg!_b\"" tmp/META-INF/com/google/android/update-binary
			sed -i "/#firmware/i package_extract_file \"images/!fwimg!.img\" \"/dev/block/bootdevice/by-name/!fwimg!_a\"" tmp/META-INF/com/google/android/update-binary
		)
	)
	if "!devicePlatform!" == "MTK" sed -i "s/bootdevice\///g" tmp/META-INF/com/google/android/update-binary
	for /f %%i in ('echo.!deviceCode!^|tr A-Z a-z') do (set lowerCode=%%i)
	sed -i "s/deviceCode/!lowerCode!/g" tmp/META-INF/com/google/android/update-binary
	dos2unix tmp/PureSkyFlashUnix.sh
	unix2dos tmp/PureSkyFlashWindows.bat
	dos2unix tmp/META-INF/com/google/android/update-binary
)

call :SUBMITPROGRESS 85 ѹ��


:CHECKNET_THIRD
curl -sS "https://jk.511i.cn" 1>nul 2>nul
if not errorlevel 0 (
	!RED! ��������������ӣ������������
	pause
	goto CHECKNET_THIRD
) else (
	!GREEN! �������ͨ��
)

rm -rf tmp/config
rm -rf tmp/output
cp -rf !diyId!_log.log tmp/!diyId!_log.log
if exist bin\recovery\!androidVersion!-!deviceCode!-recovery.img cp -rf bin/recovery/!androidVersion!-!deviceCode!-recovery.img tmp/images/recovery_twrp.img


REM �Ƿ�ѹ��ˢ����
if not exist ROM��� md ROM���
if "!flashType!" NEQ "Recovery" set /p zipOrNot="[%time:~0,8%] �Ƿ��ˢ��������ѹ����(Y/N)[Ĭ��:Y]->"
if /i "!zipOrNot!" == "N" (
	echo.[%time:~0,8%] ��ѹ��ˢ����>>!diyId!_log.log
	move tmp ROM���\!diyId!_PureSkyDiy_!deviceCode!_!deviceName!_!romVersion!_!hashkey!_!flashType!_!androidVersion!.zip 1>nul 2>nul
	goto FINISH
)

echo.[%time:~0,8%] ѹ��ˢ����>>!diyId!_log.log
cd tmp
7z a !diyId!_PureSkyDiy_!deviceCode!_!deviceName!_!romVersion!_!flashType!_!androidVersion!.zip ./

for /f %%i in ('md5sum !diyId!_PureSkyDiy_!deviceCode!_!deviceName!_!romVersion!_!flashType!_!androidVersion!.zip ^|head -c 10') do (set hashkey=%%i)
mv !diyId!_PureSkyDiy_!deviceCode!_!deviceName!_!romVersion!_!flashType!_!androidVersion!.zip ../!diyId!_PureSkyDiy_!deviceCode!_!deviceName!_!romVersion!_!hashkey!_!flashType!_!androidVersion!.zip
cd ..\
move !diyId!_PureSkyDiy_!deviceCode!_!deviceName!_!romVersion!_!hashkey!_!flashType!_!androidVersion!.zip ROM���\ 1>nul 2>nul
if "!arg!"  NEQ "--debug" rd /s /q \\?\!CD!\tmp 1>nul 2>nul
if "!arg!"  NEQ "--debug" del /s /q \\?\!CD!\tmp 1>nul 2>nul

:FINISH
echo.[%time:~0,8%] �������>>!diyId!_log.log

call :SUBMITPROGRESS 100 ���

:CHECKNET_FOURTH
curl -sS "https://jk.511i.cn" 1>nul 2>nul
if not errorlevel 0 (
	!RED! ��������������ӣ������������
	pause
	goto CHECKNET_FOURTH
) else (
	!GREEN! �������ͨ��
)

call :SUBMITPROGRESS 100 ��� -n !diyId!_PureSkyDiy_!deviceCode!_!deviceName!_!romVersion!_!hashkey!_!flashType!_!androidVersion!.zip
echo.
!CYAN! ROM�������ROM����ļ��У�!diyId!_PureSkyDiy_!deviceCode!_!deviceName!_!romVersion!_!hashkey!_!flashType!_!androidVersion!.zip
!CYAN! ROM�������ROM����ļ��У�!diyId!_PureSkyDiy_!deviceCode!_!deviceName!_!romVersion!_!hashkey!_!flashType!_!androidVersion!.zip
!CYAN! ROM�������ROM����ļ��У�!diyId!_PureSkyDiy_!deviceCode!_!deviceName!_!romVersion!_!hashkey!_!flashType!_!androidVersion!.zip
echo.
!GREEN! ������û� !myUsername! ���ƺ�Ϊ !myDiyID! ��ROM����
!GREEN! ������û� !myUsername! ���ƺ�Ϊ !myDiyID! ��ROM����
!GREEN! ������û� !myUsername! ���ƺ�Ϊ !myDiyID! ��ROM����
echo.
!YELLOW! ˢ��֮ǰ���鱣��˴��ڻ��ƴ˴������ݱ�������������BUG���߱���ʱ�����Ų飡
!YELLOW! ˢ��֮ǰ���鱣��˴��ڻ��ƴ˴������ݱ�������������BUG���߱���ʱ�����Ų飡
!YELLOW! ˢ��֮ǰ���鱣��˴��ڻ��ƴ˴������ݱ�������������BUG���߱���ʱ�����Ų飡
echo.
pause
exit






::=====================================================================
::
::
::    FUNCTIONS CALL
::
::
::=====================================================================






REM ����̨��ɫ���
:PRINTRED
	cecho [%time:~0,8%] {0C}%*{0F}{\n}
	call :WRITELOG %*
	exit /b 0


:PRINTGREEN
	cecho [%time:~0,8%] {0A}%*{0F}{\n}
	call :WRITELOG %*
	exit /b 0


:PRINTYELLOW
	cecho [%time:~0,8%] {0E}%*{0F}{\n}
	call :WRITELOG %*
	exit /b 0


:PRINTCYAN
	cecho [%time:~0,8%] {0B}%*{0F}{\n}
	call :WRITELOG %*
	exit /b 0


:WRITELOG
	echo.[%time:~0,8%] %*>>!diyId!_log.log
	exit /b 0


REM �����ļ�
:CLEANUP
	rm -rf *PSDiy*
	rm -rf *dtb*
	rm -rf *kernel*
	rm -rf *ramdisk.cpio*
	rm -rf *TwoInOne*
	rm -rf *Fastboot*
	rm -rf *Recovery*
	rm -rf *stackdump* 
	rd /s /q \\?\!CD!\tmp 1>nul 2>nul
	del /f /a /q \\?\!CD!\tmp 1>nul 2>nul
	rm -rf *.img
	rm -rf config
	rm -rf system odm vendor odm_dlkm system_dlkm
	rm -rf system_ext product vendor_dlkm
	rm -rf stub.apk util_functions.sh
	rm -rf magisk32 magisk64 magiskinit 
	rm -rf system_fs_config_pangu system_file_contexts_pangu
	md tmp
	!GREEN! �ļ��������
	exit /b 0


REM �ύ����
:SUBMITPROGRESS
	set progress=%1
	set state=%2
	set opt=%3
	set romout=%4
	if "!opt!" == "-n" (
		!YELLOW! �ύROM����:!romout!
		curl -skS "xxxx" 1>nul 2>nul
	) else (
		if "!param!" == "--admin" (
			!YELLOW! [debug]-����[!progress!]�����ύ
		) else (
			!YELLOW! �ύ����[!progress!]-[!state!]
			for /f %%i in ('echo.!state!^|iconv -f gbk -t utf8') do (set state=%%i)
			curl -skS "xxxx" 1>nul 2>nul
		)
	)
	set progress=
	set state=
	exit /b 0


REM ��ȡ���� %1
:EXTRACTIMG
	set imgFile=%1
	for /f %%i in ('basename !imgFile! ^|cut -d "." -f 1') do (set tmpName=%%i)
	!CYAN! ������ȡ !tmpName!.img
	rd /s /q \\?\!CD!\!tmpName! 1>nul 2>nul
	del /s /q \\?\!CD!\!tmpName! 1>nul 2>nul
	imgextractor !imgFile! 1>nul 2>nul
	if exist !tmpName! (
		call :WRITELOG !tmpName!_fs=ext4
		!GREEN! ����[!tmpName!],�ļ�ϵͳ[ext4]
		sed -i "/+found/d" config/!tmpName!_file_contexts
	) else (
		extract.erofs -x -i !imgFile! 1>nul 2>nul
		call :WRITELOG !tmpName!_fs=erofs
		!GREEN! ����[!tmpName!],�ļ�ϵͳ[erofs]
	)
	REM if "!tmpName!" == "product" (
		REM rd /s /q \\?\!CD!\product\media\theme\miui_mod_icons 1>nul 2>nul
		REM del /f /a /q \\?\!CD!\product\media\theme\miui_mod_icons 1>nul 2>nul
	REM )
	REM if "!tmpName!" == "system" (
		REM rd /s /q \\?\!CD!\system\system\media\theme\miui_mod_icons 1>nul 2>nul
		REM del /f /a /q \\?\!CD!\system\system\media\theme\miui_mod_icons 1>nul 2>nul
	REM )
	move !tmpName! tmp\ 1>nul 2>nul
	move config\*!tmpName!* tmp\config\ 1>nul 2>nul
	rm -rf !imgFile!
	rm -rf config
	set tmpName=
	set imgFile=
	exit /b 0


:MAKE_EROFS_IMG
	set tmpName=%1
	if "!arg!" == "--debug" (
		mkfs.erofs --mount-point !tmpName! --fs-config-file tmp/config/!tmpName!_fs_config --file-contexts tmp/config/!tmpName!_file_contexts tmp/output/!tmpName!.img tmp/!tmpName!
	) else (
		mkfs.erofs --mount-point !tmpName! --fs-config-file tmp/config/!tmpName!_fs_config --file-contexts tmp/config/!tmpName!_file_contexts tmp/output/!tmpName!.img tmp/!tmpName! 1>nul 2>nul
	)
	if exist tmp\output\!tmpName!.img (
		!GREEN! �ɹ���[erofs]���[!tmpName!.img]
	) else (
		!RED! �޷���[erofs]���[!tmpName!.img]
		mkfs.erofs --mount-point !tmpName! --fs-config-file tmp/config/!tmpName!_fs_config --file-contexts tmp/config/!tmpName!_file_contexts tmp/output/!tmpName!.img tmp/!tmpName!
		pause
		exit
	)
	set tmpName=
	exit /b 0




:MAKE_EXT4_IMG
	set tmpName=%1
	echo.date +%%s>tmp\timeStamp.sh
	dos2unix tmp/timeStamp.sh
	for /f %%i in ('bash tmp/timeStamp.sh') do (set timeStamp=%%i)
	del tmp\timeStamp.sh
	!GREEN! ʹ�õ�ǰʱ������: [!timeStamp!]
	for /f %%i in ('du -sb tmp/!tmpName! ^|tr -cd 0-9') do (set size=%%i)
	if "!tmpName!" == "odm" set extraSize=8388608
	if "!tmpName!" == "vendor" set extraSize=134217728
	if "!tmpName!" == "system" set extraSize=134217728
	if "!tmpName!" == "product" set extraSize=134217728
	if "!tmpName!" == "system_ext" set extraSize=67108864
	for /f %%i in ('echo.!extraSize!+!size! ^|bc') do (set size=%%i)
	if "!arg!" == "--debug" (
		make_ext4fs -J -T !timeStamp! -S tmp/config/!tmpName!_file_contexts -l !size! -C tmp/config/!tmpName!_fs_config -a !tmpName! -L !tmpName! tmp/output/!tmpName!.img tmp/!tmpName!
	) else (
		make_ext4fs -J -T !timeStamp! -S tmp/config/!tmpName!_file_contexts -l !size! -C tmp/config/!tmpName!_fs_config -a !tmpName! -L !tmpName! tmp/output/!tmpName!.img tmp/!tmpName! 1>nul 2>nul
	)
	if exist tmp\output\!tmpName!.img (
		!GREEN! �ɹ���[ext4]���[!tmpName!.img]
	) else (
		!RED! �޷���[ext4]���[!tmpName!.img]
		make_ext4fs -J -T !timeStamp! -S tmp/config/!tmpName!_file_contexts -l !size! -C tmp/config/!tmpName!_fs_config -a !tmpName! -L !tmpName! tmp/output/!tmpName!.img tmp/!tmpName!
		pause
		exit
	)
	set tmpName=
	exit /b 0