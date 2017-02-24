Describe "cphalo status" {
  It "should have storedb" {
    Test-Path "C:\Program Files\CloudPassage\data\store.db" | should be $true
  }

  It "should have data/id" {
    Test-Path "C:\Program Files\CloudPassage\data\id" | should be $true
  }

  It "should be running" {
    $cphalo = Get-Service -Name cphalo
    $cphalo.Status | should be 'running'
  }

  It "should have worker running" {
    $cphalo = Get-Process cphalow
    $cphalo | should be $true
  }
}