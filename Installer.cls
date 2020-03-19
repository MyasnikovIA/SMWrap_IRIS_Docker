Class %ZUser.Installer
{
	XData setup
	{
	<Manifest>
	  <Default Name="SourceDir" Value="#{$system.Process.CurrentDirectory()}src"/>
	  <Default Name="Namespace" Value="IRISAPP"/>
	  <Default Name="app" Value="irisapp" />
	  <Namespace Name="${Namespace}" Code="${Namespace}" Data="${Namespace}" Create="yes" Ensemble="no">
		<Configuration>
			<!--Database Name="${Namespace}" Dir="/opt/${app}/data" Create="yes" Resource="%DB_${Namespace}"/-->
			<Database Name="${Namespace}-CODE" Dir="/opt/${app}/data/${DBNAME}-CODE" Create="yes" Resource="%DB_${Namespace}"/>
			<Database Name="${Namespace}-DATA" Dir="/opt/${app}/data/${DBNAME}-DATA" Create="yes" Resource="%DB_${Namespace}"/>
		    <!--Import File="${SourceDir}" Flags="ck" Recurse="1"/-->
		</Configuration>
		<CSPApplication Url="/csp/${app}" Directory="${cspdir}${app}"  ServeFiles="1" Recurse="1" MatchRoles=":%DB_${Namespace}" AuthenticationMethods="32"
		/>
	  </Namespace>
	</Manifest>
	}


/// d ##class(%ZUser.Installer).installSmwrap()
ClassMethod installSmwrap()
{
  s OldNs=$zu(5)
  d $zu(5,"%SYS")
  s db=##class(SYS.Database).%OpenId("irislib") 
  s oldstatus=db.ReadOnly
  s db.ReadOnly=0 
  w db.%Save()
  d $system.OBJ.Load("/srccls/SMWrap.xml","c")
  s db.ReadOnly=oldstatus
  w db.%Save()
  d RUN^%ZMRPMD
  d $zu(5,OldNs)
}

ClassMethod setup(ByRef pVars, pLogLevel As %Integer = 3, pInstaller As %Installer.Installer, pLogger As %Installer.AbstractLogger) As %Status [ CodeMode = objectgenerator, Internal ]
{
  s OldNs=$zu(5)
  d $zu(5,"%SYS")
  s db=##class(SYS.Database).%OpenId("irislib") // from Iris'
  s oldstatus=db.ReadOnly
  s db.ReadOnly=0 
  w db.%Save()
  d $system.OBJ.LoadDir("/opt/irisapp/src","c")
	s rut = ##class(%Routine).%New("ZSTU")
	d rut.WriteLine("  job RunSmwrap")
	d rut.WriteLine("")
	d rut.WriteLine("  q")
	d rut.WriteLine("RunSmwrap")
	d rut.WriteLine("  d RUN^%ZMRPMD")
	d rut.WriteLine("  q")
	d rut.Compile()
	s rut = ""
  s db.ReadOnly=oldstatus
  w db.%Save()
  d $zu(5,OldNs)
  // d RUN^%ZMRPMD
  w !,"Install : ",##class(%Installer.Manifest).%Generate(%compiledclass, %code, "setup")
  q 1
}

}
