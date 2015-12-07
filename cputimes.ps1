
[void][Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms.DataVisualization")

$scriptpath = Split-Path -parent $MyInvocation.MyCommand.Definition

#frame

   $CPUTimesChart = New-object System.Windows.Forms.DataVisualization.Charting.Chart

   $CPUTimesChart.Width = 800

   $CPUTimesChart.Height = 400

   $CPUTimesChart.BackColor = [System.Drawing.Color]::White
 
#header 

   [void]$CPUTimesChart.Titles.Add("CPU times: Top 5 Processes")

   $CPUTimesChart.Titles[0].Font = "segoeuilight,20pt"

   $CPUTimesChart.Titles[0].Alignment = "topLeft"

#axis
   
   $chartarea = New-Object System.Windows.Forms.DataVisualization.Charting.ChartArea

   $chartarea.Name = "ChartArea1"

   $chartarea.AxisY.Title = "Time (Milliseconds)"

   $chartarea.AxisX.Title = "Process"

   $chartarea.AxisY.Interval = 500

   $chartarea.AxisX.Interval = 1
  

  
   $CPUTimesChart.ChartAreas.Add($chartarea)


   
   $legend = New-Object system.Windows.Forms.DataVisualization.Charting.Legend

   $legend.name = "Legend1"

   $CPUTimesChart.Legends.Add($legend)

#input
   
   $datasource = Get-Process | sort CPU | select -last 5

#attributes
   
   [void]$CPUTimesChart.Series.Add("CPU Time  (average)")

   $CPUTimesChart.Series["CPU Time  (average)"].ChartType = "Column"

   $CPUTimesChart.Series["CPU Time  (average)"].BorderWidth  = 3

   $CPUTimesChart.Series["CPU Time  (average)"].IsVisibleInLegend = $true

   $CPUTimesChart.Series["CPU Time  (average)"].chartarea = "ChartArea1"

   $CPUTimesChart.Series["CPU Time  (average)"].Legend = "Legend1"

   $CPUTimesChart.Series["CPU Time  (average)"].color = "#004FC7"
    $CPUTimesChart.Series["CPU Time  (average)"].color = "#004FC7"
	
#min-max	
	
	[void]$CPUTimesChart.Series.Add("CPU Time  (max)")
	 $CPUTimesChart.Series["CPU Time  (max)"].color = "#E82C0C"
   
	[void]$CPUTimesChart.Series.Add("CPU Time  (min)")
	 $CPUTimesChart.Series["CPU Time  (min)"].color = [System.Drawing.Color]::Green
   

	$datasource | ForEach-Object {$CPUTimesChart.Series["CPU Time  (average)"].Points.addxy( $_.Name , ($_.CPU)) }
 
 
	$maxValuePoint = $CPUTimesChart.Series["CPU Time  (average)"].Points.FindMaxByValue()
	$maxValuePoint.Color = "#E82C0C"

	$minValuePoint = $CPUTimesChart.Series["CPU Time  (average)"].Points.FindMinByValue()
	$minValuePoint.Color = [System.Drawing.Color]::Green

#render	
	
	$CPUTimesChart.SaveImage("z:\cputime.png","png")
 
   