function t{
    param(
        [string] $str,
        [int] $count
    )
    PROCESS
    {
        $pos = $str.IndexOf('comments')
        $right = $str.Substring($pos+1)
        $left = $str.Substring(0,$pos)
        $left = $left -replace '{"text":"',"insert into Post(id, title) VALUES ($count,'"
        $left = $left -replace '","',"');"
        $trash = $right.IndexOf('4}]}')
        $count+=1
        echo $left
        if($count -le 500){
            $right = $right.Substring($trash+5)
            t $right $count
        }
    }
}

$text  = Get-Content "C:\Users\dimab\Downloads\text.txt"
$count = 1.0
$text = $text -replace "'", "''"
$test = t $text $count
Out-File -FilePath C:\Users\dimab\Downloads\text_1.txt -InputObject $test -Encoding ASCII -Width 50
