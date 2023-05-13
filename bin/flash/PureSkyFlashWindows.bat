@echo off
if exist bin\platform-tools-windows\fastboot.exe PATH=bin\platform-tools-windows;%PATH%
setlocal enabledelayedexpansion
title PureSky��ˢ�ű� [����ѡ�д��ڣ�����ס��ã���ס���Ҽ���س���Ŵ���С���ڻָ�]
echo.
echo.ˢ��ע�����
echo.���״�ˢ��PureSky�ٸ���Ҫ�������
echo.�ڽ���Data�Ͳ�����Data�İ���ˢ��Ҫ�������
echo.
if exist images\super.img.zst (
	echo.����ת��...
	zstd --rm -d images/super.img.zst -o images/super.img
	if "!errorlevel!" NEQ "0" (
		echo.Super.imgת�����ܳ����벻Ҫˢ�룡
		echo.�����ʾ"No space left on device"��������Կռ䲻�㣬���ͷź����½�ѹ��ˢ��
		echo.�����������ʾ������ϵQQ 3556423385
		pause
		exit
	)
)
echo.
set /p wipeData="�Ƿ���Ҫ������ݣ�y/n��"
echo.
echo.ˢ���������벻Ҫ�Ҷ��ҵ㣬��ע�⿴����
echo.ˢ���������벻Ҫ�Ҷ��ҵ㣬��ע�⿴����
echo.ˢ���������벻Ҫ�Ҷ��ҵ㣬��ע�⿴����
echo.
for /f "tokens=*" %%i in ('curl -sS --connect-timeout 5 https://jk.511i.cn 2^>nul ^|findstr fs-22 ^|findstr lh-22 ^|awk NR^=^=2 ^|cut -d ">" -f 2 ^|cut -d "<" -f 1') do (set QQGROUP=%%i)
if "!QQGROUP!" neq "" (
	echo.������� ^<waiting for any device^> ��ǰ��Ⱥ��!QQGROUP!���ļ���������׿������
	echo.������� ^<waiting for any device^> ��ǰ��Ⱥ��!QQGROUP!���ļ���������׿������
	echo.������� ^<waiting for any device^> ��ǰ��Ⱥ��!QQGROUP!���ļ���������׿������
) else (
	echo.������� ^<waiting for any device^> ��ǰ��Ⱥ��607192055���ļ���������׿������
	echo.������� ^<waiting for any device^> ��ǰ��Ⱥ��607192055���ļ���������׿������
	echo.������� ^<waiting for any device^> ��ǰ��Ⱥ��607192055���ļ���������׿������

)

if exist images\boot_twrp.img (
	echo.
	set /p twrpOrNot="�Ƿ���ҪTWRP����y/n��"
)
if exist images\recovery_twrp.img (
	echo.
	set /p twrpOrNot="�Ƿ���ҪTWRP����y/n��"
)
if exist images\init_boot_official.img (
	if exist images\init_boot_magisk.img (
		echo.
		set /p rootOrNot="�Ƿ���ҪROOT����y/n��"
		if /i "!rootOrNot!" == "y" (
			fastboot flash init_boot_a images/init_boot_magisk.img
			fastboot flash init_boot_b images/init_boot_magisk.img
		) else (
			fastboot flash init_boot_a images/init_boot_official.img
			fastboot flash init_boot_b images/init_boot_official.img
		)
	) else (
		fastboot flash init_boot_a images/init_boot_official.img
		fastboot flash init_boot_b images/init_boot_official.img
	)
	fastboot flash boot_a images/boot_official.img
	fastboot flash boot_b images/boot_official.img
) else (
	if exist images\boot_magisk.img (
		echo.
		set /p rootOrNot="�Ƿ���ҪROOT����y/n��"
		if /i "!rootOrNot!" == "y" (
			fastboot flash boot_a images/boot_magisk.img
			fastboot flash boot_b images/boot_magisk.img
		) else (
			fastboot flash boot_a images/boot_official.img
			fastboot flash boot_b images/boot_official.img
		)
	) else (
		fastboot flash boot_a images/boot_official.img
		fastboot flash boot_b images/boot_official.img
	)
)

if exist images\boot_twrp.img (
	if /i "!twrpOrNot!" == "y" (
		fastboot flash boot_a images/boot_twrp.img
		fastboot flash boot_b images/boot_twrp.img
	)
)

if exist images\recovery_twrp.img (
	if /i "!twrpOrNot!" == "y" (
		fastboot flash recovery_a images/recovery_twrp.img
		fastboot flash recovery_b images/recovery_twrp.img
	)
)


rem


if exist images\preloader_raw.img (
	fastboot flash preloader_a images/preloader_raw.img 1>nul 2>nul
	fastboot flash preloader_b images/preloader_raw.img 1>nul 2>nul
	fastboot flash preloader1 images/preloader_raw.img 1>nul 2>nul
	fastboot flash preloader2 images/preloader_raw.img 1>nul 2>nul
)

if exist images\cust.img fastboot flash cust images/cust.img
echo.
echo.
echo.�����ʾ invalid sparse file format at header magic Ϊ������������Ǳ���
echo.�����ʾ invalid sparse file format at header magic Ϊ������������Ǳ���
echo.
echo.�����ĵȴ�������������ȡ���ڵ������ܣ�Ҳ���Կ��±���
echo.�����ĵȴ�������������ȡ���ڵ������ܣ�Ҳ���Կ��±���
echo.
echo.
if exist images\super.img fastboot flash super images/super.img
echo.
echo.
echo.ˢ��super���ܻῨһ��ʱ�䣬�����ĵȴ�����������������������ܲ�������Ҫ��ˢ
echo.ˢ��super���ܻῨһ��ʱ�䣬�����ĵȴ�����������������������ܲ�������Ҫ��ˢ
echo.
echo.�����ʱ��û�з�Ӧ���볢���ֶ�����������ˢһ��
echo.�����ʱ��û�з�Ӧ���볢���ֶ�����������ˢһ��
echo.
echo.

if /i "!wipeData!" == "y" (
	fastboot erase userdata
	fastboot erase metadata
)
fastboot set_active a
fastboot reboot

pause