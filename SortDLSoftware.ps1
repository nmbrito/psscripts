# Mass download renamer for MDT

#############################################################################################################################################################################################################################################
# filename                                                                  -> remove                                                                   -> newfilenamealt                          -> newfilename
# -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 7z2201-x64.exe                                                            -> 7z****-x64.exe                                                           -> 7z-x64.exe                              -> 7z.exe
# Instalador plugin Autenticacao.Gov.msi                                    -> Instalador*plugin*Autenticacao.Gov.msi                                   -> Instalador_plugin_Autenticacao.Gov.msi  -> Instalador_plugin_Autenticacao.Gov.msi
# Setup-edoclink-Agent-64bits-7.6.22.msi                                    -> Setup-edoclink-Agent-64bits*******.msi                                   -> Setup-edoclink-Agent-64bits.msi         -> Setup-edoclink-Agent-64bits.msi
# Firefox Setup 114.0.1.msi                                                 -> Firefox*Setup********.msi                                                -> Firefox_Setup.msi                       -> Firefox_Setup.msi
# Firefox Setup 102.12.0esr.msi                                             -> Firefox*Setup*********esr.msi                                            -> Firefox_Setup_esr.msi                   -> Firefox_Setup_esr.msi
# jre-8u371-windows-x64.exe                                                 -> jre******-windows-x64.exe                                                -> jre-windows-x64.exe                     -> jre-x64.exe
# jre-8u371-windows-i586.exe                                                -> jre******-windows-i586.exe                                               -> jre-windows-i586.exe                    -> jre-i586.exe
# KeePassXC-2.7.5-Win64.msi                                                 -> KeePassXC******-Win64.msi                                                -> KeePassXC-Win64.msi                     -> KeePassXC.msi
# system_update_5.08.01.exe                                                 -> system_update********.exe                                                -> system_update.exe                       -> system_update.exe
# PowerShell-7.3.4-win-x64.msi                                              -> PowerShell******-win-x64.msi                                             -> PowerShell-win-x64.msi                  -> PowerShell.msi
# PowerToysSetup-0.70.1-x64.exe                                             -> PowerToysSetup*******-x64.exe                                            -> PowerToysSetup-x64.exe                  -> PowerToysSetup.exe
# VSCodeUserSetup-x64-1.79.1.exe                                            -> VSCodeUserSetup-x64*******.exe                                           -> VSCodeUserSetup-x64.exe                 -> VSCodeUserSetup-x64.exe
# Microsoft.WindowsTerminal_1.17.11461.0_8wekyb3d8bbwe.msixbundle           -> Microsoft.WindowsTerminal***************************.msixbundle          -> Microsoft.WindowsTerminal.msixbundle    -> Microsoft.WindowsTerminal.msixbundle
# npp.8.5.3.Installer.x64.exe                                               -> npp*****.Installer.x64.exe                                               -> npp.Installer.x64.exe                   -> npp.exe
# PolyLens-1.1.26.msi                                                       -> PolyLens*******.msi                                                      -> PolyLens.msi                            -> PolyLens.msi
# Setup.RemoteDesktopManager.2023.1.29.0.msi                                -> Setup.RemoteDesktopManager************.msi                               -> Setup.RemoteDesktopManager.msi          -> Setup.RemoteDesktopManager.msi
# Skype-8.98.0.407.msi                                                      -> Skype***********.msi                                                     -> Skype.msi                               -> Skype.msi
# UltraVNC_1_4_20_X64_Setup.exe                                             -> UltraVNC*******_X64_Setup.exe                                            -> UltraVNC_X64_Setup.exe                  -> UltraVNC.exe
# vlc-3.0.18-win64.exe                                                      -> vlc*******-win64.exe                                                     -> vlc-win64.exe                           -> vlc.exe
# windirstat1_1_2_setup.exe                                                 -> windirstat*****_setup.exe                                                -> windirstat_setup.exe                    -> windirstat.exe
# E046963F.LenovoCompanion_10.2305.16.0_neutral_~_k1h2ywk1493x8.Msixbundle  -> E046963F.LenovoCompanion*************************************.Msixbundle -> E046963F.LenovoCompanion.Msixbundle     -> E046963F.LenovoCompanion.msixbundle
# -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Vars
## Set the path to the downloaded software files you wish to rename.
$srcPath = "DIR_GOES_HERE"
## Set the export path where you want the new renamed files to go.
$destPath = "DESTINATIONS_DIR_GOES_HERE"

# Changes current directory
cd $srcPath

# Filenames with versions in name -> Rename and move
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match '7z\d{4}-x64.exe'}                                      | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\7-Zip\7z.exe"
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match 'Instalador plugin Autenticacao.Gov.msi'}               | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\Autenticação.GOV Plugin\Instalador_plugin_Autenticacao.Gov.msi"
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match 'Setup-edoclink-Agent-64bits-\d.\d.\d{2}.msi'}          | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\EdocLink Agent\Setup-edoclink-Agent-64bits.msi"
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match 'Firefox Setup \d{3}.\d.\d.msi'}                        | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\Firefox\Firefox_Setup.msi"
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match 'Firefox Setup \d{3}.\d{2}.\desr.msi'}                  | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\Firefox ESR\Firefox_Setup_esr.msi"
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match 'jre-\du\d{3}-windows-x64.exe'}                         | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\Java Platform SE x64\jre-x64.exe"
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match 'jre-\du\d{3}-windows-i586.exe'}                        | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\Java Platform SE x86\jre-i586.exe"
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match 'KeePassXC-\d.\d.\d-Win64.msi'}                         | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\KeePassXC\KeePassXC.msi"
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match 'system_update_\d.\d{2}.\d{2}.exe'}                     | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\Lenovo System Update\system_update.exe"
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match 'PowerShell-\d.\d.\d-win-x64.msi'}                      | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\Microsoft PowerShell\PowerShell.msi"
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match 'PowerToysSetup-\d.\d{2}.\d-x64.exe'}                   | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\Microsoft PowerToys\PowerToysSetup.exe"
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match 'VSCodeUserSetup-x64-\d.\d{2}.\d.exe'}                  | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\Microsoft Visual Studio Code\VSCodeUserSetup-x64.exe"
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match 'npp.\d.\d.\d.Installer.x64.exe'}                       | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\Notepad++\npp.exe"
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match 'PolyLens-\d.\d.\d{2}.msi'}                             | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\PolyLens\PolyLens.msi"
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match 'Setup.RemoteDesktopManager.\d{4}.\d.\d{2}.\d.msi'}     | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\Remote Desktop Manager\Setup.RemoteDesktopManager.msi"
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match 'Skype-\d.\d{2}.\d.\d{3}.msi'}                          | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\Skype\Skype.msi"
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match 'UltraVNC_\d_\d_\d{2}_X64_Setup.exe'}                   | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\UltraVNC\UltraVNC.exe"
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match 'vlc-\d.\d.\d{2}-win64.exe'}                            | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\VLC\vlc.exe"
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match 'windirstat\d_\d_\d_setup.exe'}                         | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\WinDirStat\windirstat.exe"
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match 'E046963F.LenovoCompanion_\d{2}.\d{4}.\d{2}.\d_neutral_~_k1h2ywk1493x8.Msixbundle'} | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\Lenovo Vantage\E046963F.LenovoCompanion.msixbundle"
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match 'Microsoft.WindowsTerminal_\d.\d{2}.\d{5}.\d_8wekyb3d8bbwe.msixbundle'} | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\Microsoft Windows Terminal\Microsoft.WindowsTerminal.msixbundle"

# Filenames ready to copy
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match 'AnyDesk.exe'}                                  | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\AnyDesk\AnyDesk.exe"
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match 'Autenticacao.gov_Win_x64_signed.msi'}          | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\Autenticação.GOV\Autenticacao.gov_Win_x64_signed.msi"
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match 'googlechromestandaloneenterprise64.msi'}       | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\Google Chrome\googlechromestandaloneenterprise64.msi"
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match 'MicrosoftEdgeEnterpriseX64.msi'}               | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\Microsoft Edge\MicrosoftEdgeEnterpriseX64.msi"
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match 'Teams_windows_x64.msi'}                        | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\Microsoft Teams\Teams_windows_x64.msi"
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match 'Webex.msi'}                                    | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\Webex\Webex.msi"
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match 'webexapp.msi'}                                 | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\Webex Meetings\webexapp.msi"
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match 'ZoomInstallerFull.msi'}                        | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\Zoom Meetings\ZoomInstallerFull.msi"
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match 'ZoomLyncPluginSetup.msi'}                      | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\Zoom Outlook Plugin\ZoomLyncPluginSetup.msi"
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match 'ZoomOutlookPluginSetup.msi'}                   | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\Zoom Skype Plugin\ZoomOutlookPluginSetup.msi"
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match 'MicrosoftEdgeWebView2RuntimeInstallerX64.exe'} | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\Microsoft Edge WebView2\MicrosoftEdgeWebView2RuntimeInstallerX64.exe"
Get-ChildItem -Path $srcPath | Where-Object {$_.Name -match 'Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle'} | Select-Object -ExpandProperty Name | Move-Item -Force -Verbose -Destination "$destPath\Microsoft Windows Package Manager\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
