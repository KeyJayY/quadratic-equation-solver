Function Solve-QuadraticEquation {
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory=$true,
            Position=1,
            HelpMessage="Enter the value of coefficient A. (A*x^2+B*x+C=0)"
        )]
        [double]$a,

        [Parameter(
            Mandatory=$true,
            Position=2,
            HelpMessage="Enter the value of coefficient B. (A*x^2+B*x+C=0)"
        )]
        [double]$b,

        [Parameter(
            Mandatory=$true,
            Position=3,
            HelpMessage="Enter the value of coefficient C. (A*x^2+B*x+C=0)"
        )]
        [double]$c
    )

    DynamicParam {
        $delta = $b * $b - 4 * $a * $c
        if ($delta -lt 0) {
            Write-Host "Delta is less than 0. Do you want to see complex roots? (Yes/No)"
            $attribute = New-Object System.Management.Automation.ParameterAttribute
            $attribute.Position = 3
            $attribute.Mandatory = $true
            $attribute.HelpMessage = "Delta is less than 0. Do you want to see complex roots? (Yes/No)"

            $attributeCollection = new-object System.Collections.ObjectModel.Collection[System.Attribute]
            $attributeCollection.Add($attribute)

            $flag = New-Object System.Management.Automation.RuntimeDefinedParameter('answer', [string], $attributeCollection)
            $paramDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
            $paramDictionary.Add('answer', $flag)
            return $paramDictionary
        }
    }

    Begin {
       if($a -eq 0){
            Write-Error "it isn't quadratic equation" -ErrorAction Stop
       }
       $zbiorOdpowiedzi = @("Yes", "1", "y", "Y", "yes", "true", "True")
       if ($PSBoundParameters.odpowiedz -and -not $zbiorOdpowiedzi.Contains($PSBoundParameters.odpowiedz)) {
            Write-Error "equation has no real roots" -ErrorAction Stop
       }
    }


    Process {
        $delta = $b * $b - 4 * $a * $c
        if ($delta -ge 0) {
                if($delta -eq 0) {
                    $root = (-$b / (2 * $a))
                    Write-Output "equation root ($a*x^2 + $b*x + $c = 0) : x = $root"
                } else {
                    $root1 = (-$b + [math]::sqrt($delta)) / (2 * $a)
                    $root2 = (-$b - [math]::sqrt($delta)) / (2 * $a)
                    Write-Output "equation roots ($a*x^2 + $b*x + $c = 0) : x1 = $root1, x2 = $root2"
                }
            } else {
            $realPart = (-$b) / (2 * $a)
            $imaginaryPart = [math]::sqrt(-$delta) / (2 * $a)
            Write-Output "complex equation roots ($a*x^2 + $b*x + $c = 0) : x1 = $realPart + ${imaginaryPart}i, x2 = $realPart - ${imaginaryPart}i"
        }
    }
}
