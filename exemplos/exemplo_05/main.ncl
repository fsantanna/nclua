<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="nclClicks" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">

<head>

<regionBase>
	<region width="60%" height="15%" left="10%" top="10%" id="rgInput"/>
	<region width="60%" height="15%" left="10%" top="40%" id="rgOutput1"/>
	<region width="60%" height="15%" left="10%" top="70%" id="rgOutput2"/>
</regionBase>

<descriptorBase>
	<descriptor id="dsInput"   region="rgInput" focusIndex="inputIdx"/>
	<descriptor id="dsOutput1" region="rgOutput1"/>
	<descriptor id="dsOutput2" region="rgOutput2"/>
</descriptorBase>

<connectorBase>
	<causalConnector id="onBeginStart">
		<simpleCondition role="onBegin"/>
		<simpleAction role="start" max="unbounded"/>
	</causalConnector>
	<causalConnector id="onBeginStop">
		<simpleCondition role="onBegin"/>
		<simpleAction role="stop" max="unbounded"/>
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

	<media id="output1" src="output.lua" descriptor="dsOutput1">
		<property name="text"/>
	</media>

	<media id="output2" src="output.lua" descriptor="dsOutput2">
		<property name="text"/>
	</media>

    <link xconnector="onBeginStart">
		<bind role="onBegin" component="input"/>
		<bind role="start"   component="output1"/>
        <bind role="start"   component="output2"/>
    </link>

    <link xconnector="onEndAttributionSet">
		<bind role="onEndAttribution" component="input" interface="text"/>
		<bind role="set" component="output1" interface="text">
			<bindParam name="var" value="$get"/>
		</bind>
		<bind role="get" component="input" interface="text"/>
	</link>

	<link xconnector="onBeginSet">
		<bind role="onBegin" component="input" interface="select"/>
		<bind role="set" component="output2" interface="text">
			<bindParam name="var" value="$get"/>
		</bind>
		<bind role="get" component="input" interface="text"/>
	</link>

</body>

</ncl>
