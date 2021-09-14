function match-bracket ($string)
{
    $stack = [System.Collections.ArrayList]::new()
    $map = @{ '{' = '}' }
    $brackets = @('{','}')

    for ($i = 0; $i -lt $string.Length; $i++)
    {
        $p = $string[$i].ToString()
        
        if ($brackets -notcontains $p) 
        {  
            # ignore non bracket characters
        }
        elseif ($p -eq ($brackets[0]) ) # add to stack if open bracket
        { 
            [void]$stack.Add($p)
        }
        else 
        {
            if ($stack.Count -eq 0) # null check
            {   
                $h = $null 
            }
            else 
            { 
                $l = $stack[-1]
                $h = $map[$l].ToString()
                $stack.RemoveAt($stack.Count -1) # remove open from stack if matched
            }

            if ($p -ne $h) { return $false } # rogue close bracket
        }
    }
    if ($stack.Count -ne 0) { return $false } #rogue open bracket
    else { return $true }
}

# Unit Tests
match-bracket ('{}')
match-bracket ('}{')
match-bracket ('{{}')
match-bracket ('{}}')
match-bracket ('')
match-bracket ('{asdfb}tew{qgdafhigj}')