Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName system.ComponentModel
Add-Type -AssemblyName system.windows.forms
Add-Type -AssemblyName system.drawing
Add-Type -AssemblyName presentationCore
Add-Type -AssemblyName system.data

[void] [System.Reflection.Assembly]::LoadWithPartialName("system.data")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

[reflection.assembly]::LoadWithPartialName('system.data')
[reflection.assembly]::LoadWithPartialName('System.Speech')

[System.Windows.Forms.Application]::EnableVisualStyles()

$frm = New-Object System.Windows.Forms.Form
$frm.Text = "write pad"
$frm.size = New-Object System.Drawing.Size(900,700)
$frm.MaximizeBox = $true
$frm.MinimizeBox = $true
$frm.ControlBox = $true
$frm.MaximumSize = New-Object System.Drawing.Size(900,700)
$frm.MinimumSize = New-Object System.Drawing.Size(900,700)
$ico = New-Object System.Drawing.Icon('C:\Users\naty\Pictures\icons\icon13.ico') 
$bg = [System.Drawing.Image]::FromFile('C:\Users\naty\Pictures\jpgs\Back.jpg')
$frm.BackgroundImage = $bg
$frm.Icon = $ico
$frm.KeyPreview = $true
$frm.Dock = "fill"
$frm.StartPosition = "manual"

function printt ()
{
 $prn = New-Object System.Windows.Forms.Form
 $prn.Size = New-Object System.Drawing.Size(300,200)
 $prn.FormBorderStyle = 'fixedtoolwindow'
 $prn.Text = "   print"
 $prn.BackColor = [System.Drawing.Color]::Gray
 
 $drv = New-Object System.Windows.Forms.TextBox
 $drv.Location = New-Object System.Drawing.Size(50,50)
 $drv.Size = New-Object System.Drawing.Size(120,0)
 $drv.BackColor = [System.Drawing.Color]::tan
 $drv.ForeColor = [System.Drawing.Color]::White
 $prn.Controls.Add($drv)
 
 $drvl = New-Object System.Windows.Forms.Label
 $drvl.BackColor = [System.Drawing.Color]::Transparent
# $drvl.Font = New-Object System.Drawing.Font("Microsoft Sans Serif",10, [System.Drawing.FontStyle]::Bold)
 $drvl.location = New-Object System.Drawing.Size(10,50)
 $drvl.Text = "Driver:"
 $drvl.Size = New-Object System.Drawing.Size(40,20)
 $prn.Controls.Add($drvl)
 
 $prin = New-Object System.Windows.Forms.Button
 $prin.Location = New-Object System.Drawing.Size(50,70)
 $prin.FlatStyle = 'system'
 $prin.Size = New-Object System.Drawing.Size(120,20)
 $prin.Text = "Print"
 $prin.add_click({
        foreach ($tmp in $rtr.Text)
        {
         $r = $rr
         $rr = "$r
$tmp"
        }
        $rr |Out-File $env:TEMP/fff
        $dr = $drv.Text
        cmd /c print /D:$dr $env:TEMP/fff
        })
 $prn.Controls.Add($prin)

 $prn.ShowDialog()
}

function web ()
{
 $web = New-Object System.Windows.Forms.Form
 $web.Size = New-Object System.Drawing.Size(300,200)
 $web.BackColor = 'gray'
 $web.FormBorderStyle = 'fixedtoolwindow'
 $web.Text = '   web'

 $ins = New-Object System.Windows.Forms.TextBox
 $ins.Location = New-Object System.Drawing.Size(50,50)
 $ins.Size = New-Object System.Drawing.Size(120,0)
 $ins.BackColor = 'tan'
 $web.Controls.Add($ins)

 $insl = New-Object System.Windows.Forms.Label
 $insl.Location = New-Object System.Drawing.Size(2,50)
 $insl.Text = 'URL/IP:'
 $insl.Size = New-Object System.Drawing.Size(55,20)
 $insl.TextAlign = 'middlecenter'
 $insl.BackColor = 'transparent'
 $web.Controls.Add($insl)

 $ok = New-Object System.Windows.Forms.Button
 $ok.Text = "Ok"
 $ok.Location = New-Object System.Drawing.Size(50,70)
 $ok.Size = New-Object System.Drawing.Size(120,25)
 $ok.FlatStyle = 'system'
 $ok.add_click({
        $uri = $ins.Text
        (Invoke-WebRequest -Uri $uri).content |Out-File $env:TEMP/rr
        foreach ($tmp in (Get-Content $env:TEMP/rr))
        {
         $rtr.text = "$rtrrr
$tmp"
         $rtrrr = $rtr.text
        }
        })
 $web.Controls.Add($ok)
 $web.ShowDialog()

}

function runas ()
{
 $run = New-Object System.Windows.Forms.Form
 $run.Icon = New-Object System.Drawing.Icon('C:\Users\naty\Pictures\icons\icon13.ico')
 $run.ControlBox = $false
 $run.MaximizeBox = $false
 $run.MinimizeBox = $false
 $run.Size = New-Object System.Drawing.Size(400,300)
 $run.DesktopLocation = New-Object System.Drawing.Size(300,300)
 $run.BackColor = "gray"
 $run.ForeColor = "white"
 $run.Text = "run as"
 $run.FormBorderStyle = 'fixed3D'

 $python = New-Object System.Windows.Forms.Button
 $python.Text = "run as python"
 $python.Location = New-Object System.Drawing.Size(20,20)
 $python.Size = New-Object System.Drawing.Size(110,25)
 $python.add_click({
        cd python
        Set-Content tmp.py $rtr.Text
        start python.exe tmp.py
        cd ..
        })
 $run.Controls.Add($python)

 $html = New-Object System.Windows.Forms.Button
 $html.Text = "run in browser"
 $html.Location = New-Object System.Drawing.Size(20,50)
 $html.Size = New-Object System.Drawing.Size(110,25)
 $html.add_click({
        Set-Content tmp.html $rtr.Text
        start tmp.html
        sleep 1
    })
 $run.Controls.Add($html)

 $bat = New-Object System.Windows.Forms.Button
 $bat.Text = "run as batch"
 $bat.Location = New-Object System.Drawing.Size(20,80)
 $bat.Size = New-Object System.Drawing.Size(110,25)
 $bat.add_click({
        Set-Content tmp.bat $rtr.Text
        start tmp.bat
        })
 $run.Controls.Add($bat)
 $run.ShowDialog()

}

function detect ()
{
 $det = New-Object System.Windows.Forms.Form
 $det.Icon = New-Object System.Drawing.Icon('C:\Users\naty\Pictures\icons\icon13.ico') 
 $det.BackColor = "gray"
 $det.ForeColor = "white"
 $det.MinimizeBox = $false
 $det.MaximizeBox = $false
 $det.ControlBox = $false
 $det.Size = New-Object System.Drawing.Size(300,200)
 $det.MaximumSize = New-Object System.Drawing.Size(300,200)
 $det.MinimumSize = New-Object System.Drawing.Size(300,200)
 $det.FormBorderStyle = 'fixed3D'

 $twhat = New-Object System.Windows.Forms.TextBox
 $twhat.Enabled = $false
 $twhat.Multiline = $true
 $twhat.ReadOnly = $true
 $twhat.Location = New-Object System.Drawing.Size(105,30)
 $twhat.Size = New-Object System.Drawing.Size(200,30)
 $twhat.BackColor = "black"
 $twhat.ForeColor = "lightgreen"
 $det.Controls.Add($twhat)
 
 $btn = New-Object System.Windows.Forms.Button
 $btn.Location = New-Object System.Drawing.Size(10,30)
 $btn.Size = New-Object System.Drawing.Size(70,30)
 $btn.Text = "start"
 $btn.add_click({
    $twhat.Text = "Detecting"
    sleep 1
    $twhat.Text = "Detecting."
    sleep 1
    $twhat.Text = "Detecting.."
    sleep 1
    $twhat.Text = "Detecting..."
    sleep 1
    Set-Content tmp.tmp $rtr.text
    $what = .\detect.bat tmp.tmp
    $twhat.Enabled = $true
    if ($what -eq $null)
    {
    $twhat.Text = "unknown script"
    } else {
            $twhat.Text = "script is $what"
           }
    Remove-Item tmp.tmp
    })
 $det.Controls.Add($btn)
 $det.ShowDialog()

}

function style ()
{
 $style = New-Object System.Windows.Forms.Form
 $style.Text = "style"
 $style.BackColor = "gray"
 $style.ForeColor = "white"
 $style.FormBorderStyle = 'fixed3D'
 $style.MaximizeBox = $false
 $style.MinimizeBox = $false
 $style.Icon = New-Object System.Drawing.Icon('C:\Users\naty\Pictures\icons\icon13.ico')
 $style.ControlBox = $false
 $style.Size = New-Object System.Drawing.Size(300,250)
 $style.MinimumSize = New-Object System.Drawing.Size(300,250)
 $style.MaximumSize = New-Object System.Drawing.Size(300,250)
 $style.DesktopLocation = New-Object System.Drawing.Size(300,300)

 $dark = New-Object System.Windows.Forms.Button
 $dark.Text = "dark mode"
 $dark.Location = New-Object System.Drawing.Size(10,20)
 $dark.Size = New-Object System.Drawing.Size(60,30)
 $dark.add_click({
    $uback.selecteditem = "gray"
    $ufore.selecteditem = "white"
    $rtr.BackColor = "gray"
    $rtr.ForeColor = "white"
    })
 $style.Controls.Add($dark)
 $ter = New-Object System.Windows.Forms.Button
 $ter.Text = "Terminal>_"
 $ter.Location = New-Object System.Drawing.Size(10,90)
 $ter.Size = New-Object System.Drawing.Size(60,30)
 $ter.add_click({
    $rtr.Font = New-Object System.Drawing.Font("lucida console" , 10)
    $uback.selecteditem = "black"
    $ufore.selecteditem = "lightgreen"
    $rtr.BackColor = "black"
    $rtr.ForeColor = "lightgreen"
    })
 $style.Controls.Add($ter)

 $light = New-Object System.Windows.Forms.Button
 $light.Text = "light mode"
 $light.Location = New-Object System.Drawing.Size(10,55)
 $light.Size = New-Object System.Drawing.Size(60,30)
 $light.add_click({
    $uback.selecteditem = "white"
    $ufore.selecteditem = "black"
    $rtr.BackColor = "white"
    $rtr.ForeColor = "black"
    })
 $style.Controls.Add($light)

 $trns = New-Object System.Windows.Forms.Button
 $trns.Text = 'transparent'
 $trns.Location = New-Object System.Drawing.Size(10,125)
 $trns.Size = New-Object System.Drawing.Size(60,30)
 $trns.add_click({
        $frm.BackColor = 'black'
        $men.BackColor = 'black'
        $frm.AllowTransparency = $true
        $frm.TransparencyKey = '0'
        })
 $style.Controls.Add($trns)

 $uback = New-Object System.Windows.Forms.ListBox
 $uback.SelectionMode = 'one'
 $uback.Size = New-Object System.Drawing.Size(80,100)
 $uback.Location = New-Object System.Drawing.Size(80,20)
 [void] $uback.Items.Add("black")
 [void] $uback.Items.Add("white")
 [void] $uback.items.Add("red")
 [void] $uback.Items.Add("blue")
 [void] $uback.Items.Add("gray")
 [void] $uback.Items.Add("tan")
 [void] $uback.Items.Add("yellow")
 [void] $uback.Items.Add("green")
 [void] $uback.Items.Add("purple")
 [void] $uback.Items.Add("orange")
 [void] $uback.Items.Add("darkred")
 [void] $uback.Items.Add("darkblue")
 [void] $uback.Items.Add("darkgray")
 [void] $uback.Items.Add("darkgreen")
 [void] $uback.Items.Add("darkorange")
 [void] $uback.Items.Add("lightred")
 [void] $uback.Items.Add("lightblue")
 [void] $uback.Items.Add("lightgray")
 [void] $uback.Items.Add("lightgreen")
 [void] $uback.Items.Add("lightorange")
 $bc = $rtr.backcolor
 $uback.SelectedItem = $bc

 $style.Controls.Add($uback)

 $ubackl = New-Object System.Windows.Forms.Label
 $ubackl.Text = "backcolor"
 $ubackl.BackColor = "gray"
 $ubackl.ForeColor = "white"
 $ubackl.Location = New-Object System.Drawing.Size(80,122)
 $ubackl.Size = New-Object System.Drawing.Size(80,30)
 $style.Controls.Add($ubackl)

 $ufore = New-Object System.Windows.Forms.ListBox
 $ufore.SelectionMode = 'one'
 $ufore.Size = New-Object System.Drawing.Size(80,100)
 $ufore.Location = New-Object System.Drawing.Size(170,20)
 [void] $ufore.Items.Add("black")
 [void] $ufore.Items.Add("white")
 [void] $ufore.items.Add("red")
 [void] $ufore.Items.Add("blue")
 [void] $ufore.Items.Add("gray")
 [void] $ufore.Items.Add("tan")
 [void] $ufore.Items.Add("yellow")
 [void] $ufore.Items.Add("green")
 [void] $ufore.Items.Add("purple")
 [void] $ufore.Items.Add("orange")
 [void] $ufore.Items.Add("darkred")
 [void] $ufore.Items.Add("darkblue")
 [void] $ufore.Items.Add("darkgray")
 [void] $ufore.Items.Add("darkgreen")
 [void] $ufore.Items.Add("darkorange")
 [void] $ufore.Items.Add("lightred")
 [void] $ufore.Items.Add("lightblue")
 [void] $ufore.Items.Add("lightgray")
 [void] $ufore.Items.Add("lightgreen")
 [void] $ufore.Items.Add("lightorange")
 $ufore.SelectedItem = $rtr.forecolor

 $style.Controls.Add($ufore)
 $uforel = New-Object System.Windows.Forms.Label
 $uforel.Text = "forecolor"
 $uforel.BackColor = "gray"
 $uforel.ForeColor = "white"
 $uforel.Location = New-Object System.Drawing.Size(170,122)
 $uforel.Size = New-Object System.Drawing.Size(80,30)
 $style.Controls.Add($uforel)

 $ok = New-Object System.Windows.Forms.Button
 $ok.Text = "OK"
 $ok.Location = New-Object System.Drawing.Size(20,160)
 $ok.Size = New-Object System.Drawing.Size(70,20)
 $ok.add_click({
        $style.Close()
        })
 $style.Controls.Add($ok)

 $apply = New-Object System.Windows.Forms.Button
 $apply.Text = "Apply"
 $apply.Size = New-Object System.Drawing.Size(70,20)
 $apply.Location = New-Object System.Drawing.Size(120,160)
 $apply.add_click({
        $bc = $uback.SelectedItem
        $fc = $ufore.SelectedItem
        $rtr.BackColor = $bc
        $rtr.ForeColor = $fc
        })
 $style.Controls.Add($apply)

 $style.ShowDialog()

}
function speek ()
{
 [reflection.assembly]::LoadWithPartialName('System.Speech')
 $pr = New-Object System.Speech.Synthesis.SpeechSynthesizer
 $pr.SelectVoiceByHints('female')
 $pr.Rate = 0
 $pr.Speak("Naty speech activated")
 $speek = New-Object System.Windows.Forms.Form
 $speek.Text = "speech"
 $speek.Size = New-Object System.Drawing.Size(300,200)
 $speek.Location = New-Object System.Drawing.Size(1,1)
 $speek.MaximizeBox = $false
 $speek.MinimizeBox = $false
 $speek.ControlBox = $false
 $speek.BackColor = "gray"
 $speek.ForeColor = "white"
 $speek.FormBorderStyle = 'fixed3D'
 $speek.Icon = New-Object System.Drawing.Icon('C:\Users\naty\Pictures\icons\icon13.ico')
 $mnu = New-Object System.Windows.Forms.MenuStrip
 $mnu.BackColor = "gray"
 $mnu.ForeColor = "black"
 $mn1 = New-Object System.Windows.Forms.ToolStripMenuItem
 $mn1.Text = "Male"
 $mn1.add_click({
        $pr.SelectVoiceByHints('male') 
        })
 $mnu.Items.Add($mn1)
 $mn2 = New-Object System.Windows.Forms.ToolStripMenuItem
 $mn2.Text = "female"
 $mn2.add_click({
        $pr.SelectVoiceByHints('female')
        })
 $mnu.Items.Add($mn2)
 $speek.Controls.Add($mnu)

 
 $i=0
 $voll = New-Object System.Windows.Forms.Label
 $voll.Text = "volume"
 $voll.Size = New-Object System.Drawing.Size(50,20)
 $voll.Location = New-Object System.Drawing.Size(2,96)
 $voll.BackColor = "gray"
 $voll.ForeColor = "black"
 $speek.Controls.Add($voll)
 $vol = New-Object System.Windows.Forms.ListBox
 $vol.SelectionMode = 'one'
 $vol.Size = New-Object System.Drawing.Size(50,50)
 $vol.Location = New-Object System.Drawing.Size(2,45)
 while ($i -lt 100) 
 {
 $i=$i+1
 [void] $vol.Items.Add("$i")
 }
 $vol.SelectedIndex = "20"
 $speek.Controls.Add($vol)
 $ratel = New-Object System.Windows.Forms.Label
 $ratel.Text = "rate"
 $ratel.Size = New-Object System.Drawing.Size(40,20)
 $ratel.Location = New-Object System.Drawing.Size(120,96)
 $ratel.BackColor = "gray"
 $ratel.ForeColor = "black"
 $speek.Controls.Add($ratel)

 $i=-11
 $rate = New-Object System.Windows.Forms.ListBox
 $rate.SelectionMode = 'one'
 $rate.Size = New-Object System.Drawing.Size(50,50)
 $rate.Location = New-Object System.Drawing.Size(120,45)
 while ($i -lt 10) 
 {
 $i=$i+1
 [void] $rate.Items.Add("$i")
 }
 $rate.SelectedIndex = "0"
 $speek.Controls.Add($rate)

 $read = New-Object System.Windows.Forms.Button
 $read.Text = "Read"
 $read.Location = New-Object System.Drawing.Size(50,130)
 $read.Size = New-Object System.Drawing.Size(70,30)
 $read.add_click({
     $r = $rate.SelectedItem
     $v = $vol.SelectedItem
     $pr.Rate = $r
     $pr.Volume = $v
     $ppr = $rtr.Text
     $pr.Speak("$ppr")
     })
 $speek.Controls.Add($read)
 $cancel = New-Object System.Windows.Forms.Button
 $cancel.Text = "cancel"
 $cancel.Location = New-Object System.Drawing.Size(151,130)
 $cancel.Size = New-Object System.Drawing.Size(70,30)
 $cancel.add_click({
        $speek.Close()
        })
 $speek.Controls.Add($cancel)
 $speek.ShowDialog()
 }

function save ($initialDirectory)
{
 [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") |  Out-Null

 $OpenFileDialog = New-Object System.Windows.Forms.SaveFileDialog
 $OpenFileDialog.initialDirectory = $initialDirectory
 $OpenFileDialog.filter = "Any files| *.*|text|*.txt|batch files|*.bat|PowerShell Script|*.ps1|Hyper Text MarkUp Language|*.html"
 $OpenFileDialog.ShowDialog() | Out-Null
 $OpenFileDialog.filename
}

function export ()
{
 function saveex ($initialDirectory , $format)
{
 [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") |  Out-Null

 $OpenFileDialog = New-Object System.Windows.Forms.SaveFileDialog
 $OpenFileDialog.initialDirectory = $initialDirectory
 $OpenFileDialog.filter = "$format"
 $OpenFileDialog.ShowDialog() | Out-Null
 $OpenFileDialog.filename
}
 $export = New-Object System.Windows.Forms.Form
 $export.Size = New-Object System.Drawing.Size(300,200)
 $export.MinimumSize = New-Object System.Drawing.Size(300,200)
 $export.MaximumSize = New-Object System.Drawing.Size(300,200)
 $export.MaximizeBox = $false
 $export.MinimizeBox = $false
 $export.ForeColor = "white"
 $export.BackColor = "gray"
 $export.ControlBox = $true
 $export.Text = "Export as"
 $export.Icon = New-Object System.Drawing.Icon('C:\Users\naty\Pictures\icons\icon13.ico') 
 $export.FormBorderStyle = 'fixed3D'
 
 $html = New-Object system.windows.forms.button
 $html.Text = "export as html"
 $html.Size = New-Object System.Drawing.Size(100,30)
 $html.Location = New-Object System.Drawing.Size(30,60)
 $html.add_click({
    $htmlsave = saveex -initialDirectory $env:USERPROFILE -format 'html|*.html'
    $date = Get-Date
    Write-Host $rtr.Text |Out-File tmp.txt
    foreach ($tmp in $rtr.Text)
    {
     $toh = "$toh <br>$tmp</br>"
    }
    $tt = $rtr.Text
    Write-Host "" |ConvertTo-Html -Title "exported at $date" -Body "<br> $tt </br>" |Out-File $htmlsave
    Remove-Item tmp.txt
    })
 $export.Controls.Add($html)

 $csv = New-Object System.Windows.Forms.Button
 $csv.Text = "export as csv"
 $csv.Size = New-Object System.Drawing.Size(100,30)
 $csv.Location = New-Object System.Drawing.Size(30,20)
 $csv.add_click({
        function csv ()
        {
         "$rtr.text"
        }
        $csvsave = saveex -initialDirectory $env:USERPROFILE -format 'exel|*.csv'
        csv |Out-File $csvsave
        }) 
 $export.Controls.Add($csv)

 $bat = New-Object System.Windows.Forms.Button
 $bat.Text = "compile to exe as batch"
 $bat.Size = New-Object System.Drawing.Size(110,40)
 $bat.Location = New-Object System.Drawing.Size(145,20)
 $bat.add_click({
         

         $batsave = saveex -initialDirectory $env:ALLUSERSPROFILE -format 'Application|*.exe'
         cd  .\adv\anc
         Remove-Item tmp.bat
         Set-Content tmp.bat $rtr.Text 
         <#foreach ($tmp in Get-Content tmpp.bat)
         {
          .\write.bat $tmp tmp.bat
         }#>
         .\wr.bat $batsave
         sleep 4
         #Remove-Item tmp.bat
         cd ..
         cd ..
         })
 $export.Controls.Add($bat)


 $pdf = New-Object System.Windows.Forms.Button
 $pdf.Text = "export as pdf"
 $pdf.Size = New-Object System.Drawing.Size(100,30)
 $pdf.Location = New-Object System.Drawing.Size(30,100)
 $pdf.add_click({
    $rtr.text |Out-Printer
     })
 $export.Controls.Add($pdf)
 $export.ShowDialog()
 }
    



function mksave ()
{
 $tosave = save -initialDirectory $env:USERPROFILE
 
  Set-Content $tosave $rtr.text
 
}


function font () 
{
 $font = New-Object System.Windows.Forms.Form
 $font.Size = New-Object System.Drawing.Size(300,200)
 $font.MaximizeBox = $false
 $font.MaximumSize = New-Object System.Drawing.Size(300,200)
 $font.MinimizeBox = $false
 $font.Icon = New-Object System.Drawing.Icon('C:\Users\naty\Pictures\icons\icon13.ico')
 $font.MinimumSize = New-Object System.Drawing.Size(300,200)
 $font.Text = "font"
 $font.ControlBox = $false
 $font.FormBorderStyle = 'fixed3D'
 $font.BackColor = "darkgray"
 $font.ForeColor = "black"

 $flist = New-Object System.Windows.Forms.ListBox
 $flist.SelectionMode = 'one'
 $flist.BackColor = "gray"
 $flist.ForeColor = "white"
 $selected = $rtr.Font.Name
 $flist.Location = New-Object System.Drawing.Size(1,10)
 $flist.Size = New-Object System.Drawing.Size(100,60)
 [void] $flist.Items.Add("Arial")
 [void] $flist.items.Add("Microsoft Sans Serif")
 [void] $flist.Items.Add("Bradley Hand ITC")
 [void] $flist.Items.Add("Addis98")
 [void] $flist.Items.Add("AGF - Dawit")
 [void] $flist.Items.Add("AGF - Ejji Tsihuf")
 [void] $flist.Items.Add("AGF - Zemen")
 [void] $flist.Items.Add("Visual Geez Unicode")
 [void] $flist.Items.Add("VG2 Agazian")
 [void] $flist.Items.Add("Power Geez Unicode1")
 [void] $flist.Items.Add("Power Geez Unicode2")
 [void] $flist.Items.Add("Power Geez Unicode3")
 $flist.SelectedItem = $selected
 $font.Controls.Add($flist)


 
 $fsize = New-Object System.Windows.Forms.ListBox
 $fsize.SelectionMode = 'one'
 $fsize.BackColor = "gray"
 $fsize.ForeColor = "white"
 $sislct = $rtr.Font.Size
 $fsize.Location = New-Object System.Drawing.Size(120,10)
 $fsize.size = New-Object System.Drawing.Size(70,60)
 $i = 0
 while ($i -lt 90)
 {
  $i=$i+1
  [void] $fsize.Items.Add("$i")
 }
 $fsize.SelectedItem = 8
 $font.controls.Add($fsize)

 $fk = New-Object System.Windows.Forms.Button
 $fk.Text = "Apply"
 $fk.Size = New-Object System.Drawing.Size(60,20)
 $fk.Location = New-Object System.Drawing.Size(185,130)
 $fk.add_click({
    $fnt = $flist.SelectedItem
    $fnts = $fsize.SelectedItem
    $rtr.Font = New-Object System.Drawing.Font("$fnt", $fnts)
    write-host "$fnt recrce"
    
    })

 $font.Controls.Add($fk)
 $fo = New-Object System.Windows.Forms.Button
 $fo.Text = "Ok"
 $fo.Size = New-Object System.Drawing.Size(60,20)
 $fo.Location = New-Object System.Drawing.Size(35,130)
 $fo.add_click({
    $fnt = $flist.SelectedItem
    $fnts = $fsize.SelectedItem
    $rtr.Font = New-Object System.Drawing.Font("$fnt", $fnts)
    write-host "$fnt recrce"
    $font.Close()
    })
 $fc = New-Object System.Windows.Forms.Button
 $fc.Text = "Cancel"
 $fc.Size = New-Object System.Drawing.Size(60,20)
 $fc.Location = New-Object System.Drawing.Size(110,130)
 $fc.add_click({
    $font.Close()
    
    })

 $font.Controls.Add($fc)
 $font.Controls.Add($fo)
 $bold = New-Object System.Windows.Forms.Button
 $bold.Font = New-Object System.Drawing.Font("Microsoft Sans Serif",9 , [System.Drawing.FontStyle]::Bold)
 $bold.Text = "Bold"
 $bold.Location  = New-Object System.Drawing.Size(210,10)
 $bold.Size = New-Object System.Drawing.Size(60,30)
 $bold.add_click({
        $bldstyle = $rtr.Font = New-Object System.Drawing.Font("$fnt", $fnts ,[System.Drawing.FontStyle]::Bold)
        })
 $font.Controls.Add($bold)
 
 $italy = New-Object System.Windows.Forms.Button
 $italy.Font = New-Object System.Drawing.Font("Microsoft Sans Serif",10 , [System.Drawing.FontStyle]::Italic)
 $italy.Text = "italic"
 $italy.Location  = New-Object System.Drawing.Size(210,45)
 $italy.Size = New-Object System.Drawing.Size(60,30)
 $italy.add_click({
        $rtr.Font = New-Object System.Drawing.Font("$fnt", $fnts ,[System.Drawing.FontStyle]::italic)
        })
 $font.Controls.Add($italy)

 $und = New-Object System.Windows.Forms.Button
 $und.Font = New-Object System.Drawing.Font("Microsoft Sans Serif",8 , [System.Drawing.FontStyle]::Underline)
 $und.Text = "underline"
 $und.Location  = New-Object System.Drawing.Size(210,80)
 $und.Size = New-Object System.Drawing.Size(60,30)
 $und.add_click({
        $rtr.Font = New-Object System.Drawing.Font("$fnt", $fnts ,[System.Drawing.FontStyle]::Underline)
        })
 $font.Controls.Add($und)
 $font.ShowDialog()
}

function add-menu ()
{
 $menu = New-Object System.Windows.Forms.MenuStrip
 $menu.Location = New-Object System.Drawing.Size(100,1)
 $menu.Size = New-Object System.Drawing.Size(140,30)
 $frm.Controls.Add($menu)
 $m1 = New-Object System.Windows.Forms.ToolStripMenuItem
 $m1.Text = "open"
$m1.add_click({
    $rt = brwse -initialDirectory $env:USERPROFILE
    $bt = $rt.text
    $frm.Size = New-Object System.Drawing.Size(900,700)
    $frm.Text = "write pad - $rt"
    $frm.MaximizeBox = $true
    $frm.MinimizeBox = $true
    $frm.ControlBox = $true
    $exist = Test-Path $rt
    if ($exist -eq $true)
    {
     $i=0
     $rtr.Text = ""
     $rtrt = ""
     foreach ($cont in Get-Content $rt) 
     {
      
      $rtr.Text = "$rtrt
 $cont"
      $i=$i+1
      $rtrt = $rtr.Text
     }
     }

})



}
$rtr = New-Object System.Windows.Forms.TextBox
        $rtr.AcceptsReturn = $true
        $rtr.Multiline = $true
        $rtr.ScrollBars = "both"
        $rtr.AcceptsTab = $true
        $rtr.BackColor = "black"
        $Rtr.Anchor = "bottom"
        $rtr.TabIndex = $true
        $rtr.BackgroundImageLayout = "zoom"
        $rtr.BorderStyle = "none"
        $rtr.add_keydown({
            if ($_.KeyCode -eq "shift")
            {
             $rtr.ForeColor = "blue"
            }
        })

        $rtr.AutoSize = $true
        $rtr.ForeColor = "lightgreen"
        $rtr.location = New-Object System.Drawing.Size(1,25)
        $rtr.Size = New-Object System.Drawing.Size(885,635)
        $frm.Controls.Remove($brw)
        $rtr.ReadOnly = $false
        $frm.Controls.Add($rtr)





Function brwse($initialDirectory)
{
 [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") |  Out-Null

 $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
 $OpenFileDialog.initialDirectory = $initialDirectory
 $OpenFileDialog.filter = "Any files| *.*|text|*.txt|batch files|*.bat|PowerShell Script|*.ps1|Hyper Text MarkUp Language|*.html"
 $OpenFileDialog.ShowDialog() | Out-Null
 $OpenFileDialog.filename
}

Function sav($initialDirectory)
{
 [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") |  Out-Null

 $OpenFilDialog = New-Object System.Windows.Forms.SaveFileDialog
 $OpenFilDialog.ShowDialog() | Out-Null
 $OpenFilDialog.filename
}

 $m1 = New-Object System.Windows.Forms.ToolStripMenuItem
 $m1.Text = "open"
 $m1.add_click({
      add-brmenu
     })

$edifrm = New-Object System.Windows.Forms.Form
$edifrm.text = "write pad - $rt"
$edifrm.MinimizeBox = $true
$edifrm.MaximizeBox = $true
$edifrm.ControlBox = $true
function add-brmenu () 
{
 $menu = New-Object System.Windows.Forms.MenuStrip
 $menu.Location = New-Object System.Drawing.Size(100,1)
 $menu.Size = New-Object System.Drawing.Size(140,30)

 $frm.Controls.Add($menu)
 $m1.add_click({
    $rt = brwse -initialDirectory $env:USERPROFILE
    $bt = $rt.text
    $frm.Size = New-Object System.Drawing.Size(900,700)
    $frm.Text = "write pad - $rt"
    $frm.MaximizeBox = $true
    $frm.MinimizeBox = $true
    $frm.ControlBox = $true
    $exist = Test-Path $rt
    if ($exist -eq $true)
    {
     $frm.Text = "Write pad - $rt"
     $rtrt = ""
     foreach ($cont in Get-Content $rt) 
     {
      $rtr.Text = "$rtrt
$cont"
      $rtrt = $rtr.Text
     }

     $sav = New-Object System.Windows.Forms.Button
     $sav.Text = "save as"
     $sav.Location = New-Object System.Drawing.Size(5,3)
     $sav.Size = New-Object System.Drawing.Size(10,30)
     $sav.add_click({
           mksave
           $init = "$rtr.Text"
           Write-Host "ayayyayaay ,,,,,,,,,,,,, $init ,,,,,,,,,,,,,,"
           Write-Host "$rtr.text" |Out-File $sv
           })
     $frm.Controls.Add($sav)
     
    }
    })

 $menu.Items.Add($m1)
 $m2 = New-Object System.Windows.Forms.ToolStripMenuItem
 $m2.Text = "save"
  if ($rtr.Text -eq $null)
 {
  $m2.Enabled = $false
 } else {
         $m2.Enabled = $true
        }
 $m2.add_click({
        Set-Content $env:USERPROFILE/saved.txt $rtr.text
     })
 $menu.Items.Add($m2)
 $m3 = New-Object System.Windows.Forms.ToolStripMenuItem
 $m3.Text = "save as"
  if ($rtr.Text -eq $null)
 {
  $m3.Enabled = $false
 } else {
         $m3.Enabled = $true
        }
 $m3.add_click({
      mksave
     })
 $menu.Items.Add($m3)
 $m4 = New-Object System.Windows.Forms.ToolStripMenuItem
 $m4.Text = "detect"
  if ($rtr.Text -eq $null)
 {
  $m4.Enabled = $false
 } else {
         $m4.Enabled = $true
        }
 $m4.add_click({
      detect
     })
 $menu.Items.Add($m4)
 $m5 = New-Object System.Windows.Forms.ToolStripMenuItem
 $m5.Text = "font"
  if ($rtr.Text -eq $null)
 {
  $m5.Enabled = $false
 } else {
         $m5.Enabled = $true
        }
 $m5.add_click({
      font
     })
 $menu.Items.Add($m5)
 $m6 = New-Object System.Windows.Forms.ToolStripMenuItem
 $m6.Text = "run as" 
 if ($rtr.Text -eq $null)
 {
  $m6.Enabled = $false
 } else {
         $m6.Enabled = $true
        }
 $m6.add_click({
      runas
     })
 $menu.Items.Add($m6)
 $m7 = New-Object System.Windows.Forms.ToolStripMenuItem
 $m7.Text = "export as"
 if ($rtr.Text -eq $null)
 {
  $m7.Enabled = $false
 } else {
         $m7.Enabled = $true
        }
 $m7.add_click({
      export
     })



 $menu.Items.Add($m7)
 $m8 = New-Object System.Windows.Forms.ToolStripMenuItem
 $m8.Text = "style"
 if ($rtr.Text -eq $null)
 {
  $m8.enabled = $false
 } else {
         $m8.Enabled = $true
        }
 $m8.add_click({
      style
     })
 $menu.Items.Add($m8)
 $m9 = New-Object System.Windows.Forms.ToolStripMenuItem
 $m9.Text = "speek"
 $m9.add_click({
    speek
    })
 $menu.Items.Add($m9)
 
 $m10 = New-Object System.Windows.Forms.ToolStripMenuItem
 $m10.Text = "web"
 $m10.add_click({
        web;
        })
 $menu.Items.Add($m10)

 $m11 = New-Object System.Windows.Forms.ToolStripMenuItem
 $m11.Text = "print"
 $m11.add_click({
        printt
        })
 $menu.Items.Add($m11)
 
 }



add-brmenu





$frm.ShowDialog()
