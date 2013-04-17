<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="nclClicks" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">

<head>

<regionBase>
	<region width="80%" height="15%" left="10%" top="20%" id="rgInput"/>
	<region width="80%" height="10%" left="10%" top="50%" id="rgOutput"/>
</regionBase>

<descriptorBase>
	<descriptor id="dsInput"  region="rgInput" focusIndex="inputIdx"/>
	<descriptor id="dsOutput" region="rgOutput"/>
</descriptorBase>

<connectorBase>
	<causalConnector id="onBeginStart">
		<simpleCondition role="onBegin"/>
		<simpleAction role="start" max="unbounded"/>
	</causalConnector>
	<causalConnector id="onBeginSet">
		<connectorParam name="var"/>
		<simpleCondition role="onBegin"/>
		<simpleAction role="set" value="$var"/>
	</causalConnector>
	
	<causalConnector id="onEndAttributionSet">
		<connectorParam name="var"/>
		<simpleCondition role="onEndAttribution"/>
		<simpleAction role="set" value="$var"/>
	</causalConnector>	
</connectorBase>

</head>

<body>
	<port id="entryPoint" component="input"/>

	<media type="application/x-ginga-settings" id="programSettings">
        <property name="service.currentKeyMaster" value="inputIdx"/>
	</media>

	<media id="input" src="input.lua"  descriptor="dsInput">
		<area id="select"/>
		<property name="text"/>
	</media>

	<media id="google" src="google.lua">
		<property name="search"/>
		<property name="result"/>
	</media>

	<media id="output" src="output.lua" descriptor="dsOutput">
		<property name="text"/>
	</media>

	<link xconnector="onBeginStart">
		<bind role="onBegin" component="input"/>
		<bind role="start"   component="google"/>
		<bind role="start"   component="output"/>
	</link>

	<link xconnector="onBeginSet">
		<bind role="onBegin" component="input" interface="select"/>
		<bind role="set" component="google" interface="search">
			<bindParam name="var" value="$get"/>
		</bind>
		<bind role="get" component="input" interface="text"/>
	</link>

	<link xconnector="onEndAttributionSet">
		<bind role="onEndAttribution" component="google" interface="result"/>
		<bind role="set" component="output" interface="text">
			<bindParam name="var" value="$get"/>
		</bind>
		<bind role="get" component="google" interface="result"/>
	</link>

</body>

</ncl>
