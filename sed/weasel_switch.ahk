;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;		not complete
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
If (A_Is64bitOS=1)
SetRegView, 64
If (A_Is64bitOS=0)
SetRegView, 32

if (A_Is64bitOS=1)
RegRead, weasel_root, HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Rime\Weasel, WeaselRoot
If (A_Is64bitOS=0)
RegRead, weasel_root, HKEY_LOCAL_MACHINE\SOFTWARE\Rime\Weasel, WeaselRoot
RegRead, rime_user_dir, HKEY_CURRENT_USER\SOFTWARE\Rime\Weasel, RimeUserDir

;deployer path
deployer = %weasel_root%\WeaselDeployer.exe
;your sed path
;sed = C:\Git\usr\bin\sed.exe
sed = %weasel_root%\sed\sed.exe
weasel_config = %rime_user_dir%\weasel.custom.yaml

F9::
{
	runwait, %sed% -i "s/capture_type:\s\+\w\+$/capture_type: highlighted/g" %weasel_config%
	runwait, %deployer% /deploy
	return
}
!F9::
{
	runwait, %sed% -i "s/capture_type:\s\+\w\+$/capture_type: none/g" %weasel_config%
	runwait, %deployer% /deploy
	return
}
