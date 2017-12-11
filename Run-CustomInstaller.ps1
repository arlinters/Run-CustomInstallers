<#
Dependent on the CSV file "Filepath" with 4 headers {Name, Path, Altpath, Switches} to be in the same directory as the script.
Name contains program name, path is the path of the installer, Altpath is for any secondary installers that need ran for the installation and switches are for any switches you need.
#> 

function Run-CustomInstaller{


#Imports needed CSV for file names, paths and switches.
$csv = Import-Csv "$PSScriptRoot\FilePaths.csv"

 

 

#Loads needed assemblies to display the gui

[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null

[reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null

 

#initializes the form, buttons and listbox

$form1 = New-Object System.Windows.Forms.Form

$button1 = New-Object System.Windows.Forms.Button

$button2 = New-Object System.Windows.Forms.Button

$button3 = New-Object System.Windows.Forms.Button

$listBox1 = New-Object System.Windows.Forms.ListBox

 

#Dynamically creates the checkbox objects. Creates enough based on the count from the objects in the CSV file.

for ($i=0; $i -lt $csv.Count; $i++)

{

New-Variable -Name "chkBox$i" -Value  {New-Object System.Windows.Forms.CheckBox}

(Get-Variable chkbox$i).Value = &  (Get-Variable chkbox$i).Value #Initializes the checkbox

}

 

 

#Dynamically creates the variables that holds the information from the csv file

#The more I look at this, the more I realize that I could probably just use $csv[$i] when needed...

# I will change this later if I remember. :-) -Charles

<#

for ($i=0; $i -lt $csv.Count; $i++){

 

New-Variable -Name "program$i" -Value  $csv[$i]

Get-Variable -Name "program$i"

 

}

#>

 

#initialize form window state object

$InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState

 

$b1= $false

$b2= $false

$b3= $false

$b4 = $false

 
$listBox1.Items.Add( "Select the software that you need.") 

#----------------------------------------------

#Generated Event Script Blocks

#----------------------------------------------

 

#What occurs when "Install" button is clicked.

$handler_button1_Click=

{

$ErrorActionPreference = 'Stop'

    $listBox1.Items.Clear();   

 

    #Loops through the checkboxes to see if they were checked. If they are, installs based on the program$i.path variable.

    #This would be a spot to replace that with $csv[$i].

for($i=0;$i -lt $csv.Count; $i++)

    {

    if((Get-Variable chkbox$i).value.Checked)

        {

            Try{

                Write-Host "Installing " -NoNewline
                # Outputs the name for the currently selected checkbox.
                write-host (Get-Variable chkbox$i).Value.Text -ForegroundColor Yellow -BackgroundColor DarkBlue

               Write-Host "Path is: " -NoNewline

                Write-Host $csv[$i].path

 

               

                Write-Host "Beginning installation of  " -NoNewline

                Write-Host $csv[$i].Name -ForegroundColor Yellow -BackgroundColor DarkBlue

                if($csv[$i].Switches){

                       Start-Process -FilePath $csv[$i].Path -ArgumentList $csv[$i].switches -wait

                     if($csv[$i].AltPath){

                        Start-Process -FilePath $csv[$i].AltPath -ArgumentList $csv[$i].switches -wait

                        }

                }

                else{

                   

                Start-Process -FilePath $csv[$i].Path -Wait

                  if($csv[$i].AltPath){

                    Start-Process -FilePath $csv[$i].AltPath -Wait

                    }

                }

               Write-Host "End of installation for " -NoNewline

                write-host $csv[$i].Name -ForegroundColor Yellow

               #Adds the name of the program to the listbox for later reference

                $listText = ($csv[$i].name)

                $listText += " installed."

                   $listBox1.Items.Add($listText)

               

                }

               

                #Standard error messages

            Catch{

                $listbox1.Items.Add( "Check PSConsole for error.")

                                         $errormessage = $_.Exception.Message             

                                         Write-Host "The error message was $errormessage." -ForegroundColor Red

                }

          }

    }

 

###################################################

 
# If no checkboxes are marked, update listbox with a message

 
####################################################

    $AllCheckBoxes = Get-Variable chkbox* #Places

    if(!($AllCheckBoxes | Where {$_.value.checked})){

            $listBox1.Items.Add("No CheckBox selected...")}

 

            }

############################################


# What happens when the Clear button is pressed


############################################

#Clears any checked boxes and also clears the listbox.

$handler_btnClear_Click = {

 

    $listBox1.Items.Clear();

    

    #Loops through checkboxes to seeif they are checked. If they are, set the checked property to false.

for($i=0;$i -lt $csv.Count; $i++){

if((Get-Variable chkbox$i).Value.checked){

(get-Variable chkbox$i).Value.Checked = $false;

}

 

}

}

########################################################

$handler_btnTest_Click = {

$ErrorActionPreference = 'Stop'

    $listBox1.Items.Clear();   

    $listBox1.Items.Add('Check Console for Paths.');

 

    #Loops through the checkboxes to see if they were checked. If they are, installs based on the program$i.path variable.

    #This would be a spot to replace that with $csv[$i].

for($i=0;$i -lt $csv.Count; $i++)

    {

 

            Try{

                Write-Host "CheckBox Title: " -NoNewline

                write-host (Get-Variable chkbox$i).Value.Text -ForegroundColor Yellow -BackgroundColor DarkBlue

               

               

               Write-Host "Path: " -NoNewline

                Write-Host $csv[$i].path

 

                Write-Host

 

                }

               

                #Standard error messages

            Catch{

                $listbox1.Items.Add( "Check PSConsole for error.")

                                         $errormessage = $_.Exception.Message             

                                         Write-Host "The error message was: $errormessage." -ForegroundColor Red

                }

          }

          #Write-Host "For this script to work, the loops for the initialization of the checkboxes, the buttons, and the checkbox properties must be identical. `nThey utilize the same 'for(`$i=0;`$i -lt `$csv.Count; `$i++)' loop."

}

$OnLoadForm_StateCorrection=

{#Correct the initial state of the form to prevent the .Net maximized form issue

    $form1.WindowState = $InitialFormWindowState

}

 

 

#----------------------------------------------

#region Generated Form Code

$form1.Text = "Run-CustomInstaller"

$form1.Name = "form1"

$form1.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Size = New-Object System.Drawing.Size

$System_Drawing_Size.Width = 600

$System_Drawing_Size.Height = 440

$form1.ClientSize = $System_Drawing_Size

#-----------------------------------------------------------

#This block contains the code for the buttons

#-----------------------------------------------------------

$button1.TabIndex = 4

$button1.Name = "button1"

$System_Drawing_Size = New-Object System.Drawing.Size

$System_Drawing_Size.Width = 75

$System_Drawing_Size.Height = 23

$button1.Size = $System_Drawing_Size

$button1.UseVisualStyleBackColor = $True

 

$button1.Text = "Install"

 

$System_Drawing_Point = New-Object System.Drawing.Point

$System_Drawing_Point.X = 480

$System_Drawing_Point.Y = 350

$button1.Location = $System_Drawing_Point

$button1.DataBindings.DefaultDataSourceUpdateMode = 0

$button1.add_Click($handler_button1_Click)

 

$form1.Controls.Add($button1)

 

$button2.TabIndex = 4

$button2.Name = "button1"

$System_Drawing_Size = New-Object System.Drawing.Size

$System_Drawing_Size.Width = 75

$System_Drawing_Size.Height = 23

$button2.Size = $System_Drawing_Size

$button2.UseVisualStyleBackColor = $True

 

$button2.Text = "Clear"

 

$System_Drawing_Point = New-Object System.Drawing.Point

$System_Drawing_Point.X = 400

$System_Drawing_Point.Y = 350

$button2.Location = $System_Drawing_Point

$button2.DataBindings.DefaultDataSourceUpdateMode = 0

$button2.add_Click($handler_btnClear_Click)

 

$form1.Controls.Add($button2)

 

$button3.Name = "button3"

$System_Drawing_Size = New-Object System.Drawing.Size

$System_Drawing_Size.Width = 155

$System_Drawing_Size.Height = 23

$button3.Size = $System_Drawing_Size

$button3.UseVisualStyleBackColor = $True

$Button3.Text = "Test Paths"

$System_Drawing_Point = New-Object System.Drawing.Point

$System_Drawing_Point.X = 400

$System_Drawing_Point.Y = 375

$button3.Location = $System_Drawing_Point

$button3.DataBindings.DefaultDataSourceUpdateMode = 0

$button3.add_Click($handler_btnTest_Click)

$form1.Controls.Add($button3);

 

#-----------------------------------------------------------

#This block contains the list box

#-----------------------------------------------------------

$listBox1.FormattingEnabled = $True

$System_Drawing_Size = New-Object System.Drawing.Size

$System_Drawing_Size.Width = 200

$System_Drawing_Size.Height = 312

$listBox1.Size = $System_Drawing_Size

$listBox1.DataBindings.DefaultDataSourceUpdateMode = 0

$listBox1.Name = "listBox1"

$System_Drawing_Point = New-Object System.Drawing.Point

$System_Drawing_Point.X = 370

$System_Drawing_Point.Y = 40

$listBox1.Location = $System_Drawing_Point

$listBox1.TabIndex = 3

 

$form1.Controls.Add($listBox1)

 

########################

# Chkbox ScriptBlock#

########################

$xcount = 0

$ycount = 0

$x = 27

$y = 13

for($i=0;$i -lt $csv.Count; $i++)

    {
        # If there are 12 items in the current row, go to the next column by adding 113 to the x drawing point
        if($xcount -ge 12){

            $x +=113

            $xcount = 0

            }
        # If there are 12 items in the current row, go to the next column by starting the y drawing point at 13. 
        if($ycount -eq 12 ){

            $y =13

            $ycount = 0

           }

 

           

    (Get-Variable chkbox$i).Value.UseVisualStyleBackColor = $True

    $system_Drawing_Size = New-Object System.Drawing.Size

    $system_Drawing_Size.Width = 100

    $system_Drawing_Size.height = 28   

    (Get-Variable chkbox$i).Value.Size = $System_Drawing_Size

    (Get-Variable chkbox$i).Value.tabindex = 1

    (Get-Variable chkbox$i).Value.text = $csv[$i].Name

     $System_Drawing_Point = New-Object System.Drawing.Point

     $system_Drawing_Point.X = $x

     $system_Drawing_Point.y = $y

    (Get-Variable chkbox$i).Value.location = $system_Drawing_Point

    (Get-Variable chkbox$i).Value.DataBindings.DefaultDataSourceUpdateMode = 0

    (Get-Variable chkbox$i).Value.name = (Get-Variable chkbox$i).Value.name

     $form1.Controls.Add((Get-Variable chkbox$i).Value)

            

             
       # Go down 31
       $y+=31

       $xcount ++

       $ycount++

}

########################

 

 

 

#Save the initial state of the form

$InitialFormWindowState = $form1.WindowState

#Init the OnLoad event to correct the initial state of the form

$form1.add_Load($OnLoadForm_StateCorrection)

#Show the Form

$form1.ShowDialog()| Out-Null

}

 

Run-CustomInstaller