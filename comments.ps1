function comment{
    param(
        [string] $str,
        [int] $count,
        [int] $j
    )
    PROCESS
    {
        
        $end = $str.IndexOf(']}')
        $start = $str.IndexOf('comments')
        $split = $str.Substring($start+11)
        $split = $split -replace '{"text":"', "insert into Comments(id,post_id, content, rating) VALUES'"
        $split = $split -replace '","score":',"', "
        $split = $split -replace '},' , ');'
        $split = $split -replace '}]' , ');'
        for($i = 0; $i -le 4;$i++){
            $half = $split.IndexOf(');')
            $line = $split.Substring(0,$half+2)
            $line = $line -replace 'VALUES', "VALUES ($j, $count, "
            $line 
            $j+=1
            $split = $split.Substring($half+2)
        }
        $count+=1
        if($count -le 500){
            $right = $str.Substring($end+3)
           comment $right $count $j
        }
    }
}

$text  = Get-Content "C:\Users\dimab\Downloads\text.txt"
$count = 1.0
$j = 1.0
$text = $text -replace "'", "''"
$test_2 = comment $text $count $j
Out-File -FilePath C:\Users\dimab\Downloads\text_2.txt -InputObject $test_2 -Encoding ASCII 