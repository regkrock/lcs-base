Class {
	#name : 'LuiSelectExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'private' }
LuiSelectExamples >> expectedHtmlWithFourSkills [
	^ '<select id="196216916" data-name="mainSkill" data-StClass="LuiSelect" class="inputField" onchange="$.ajax({&quot;url&quot;:&quot;/&quot;,&quot;data&quot;:[&quot;1&quot;,&quot;2=&quot;+encodeURIComponent($(&quot;#196216916&quot;).val())].join(&quot;&amp;&quot;),&quot;success&quot;:function(){$(&quot;#nil&quot;).load(&quot;/&quot;,&quot;3&quot;)}})"><option id="214572771" data-name="mainSkill_1" data-StClass="LuiSelectOption" value="1">Skill 1</option><option id="216237296" data-name="mainSkill_2" data-StClass="LuiSelectOption" value="2">Skill 2</option><option id="217901821" data-name="mainSkill_3" data-StClass="LuiSelectOption" value="3">Skill 3</option><option id="219566346" data-name="mainSkill_4" data-StClass="LuiSelectOption" value="unknown" selected>unknown</option></select>'
]

{ #category : 'examples' }
LuiSelectExamples >> firstOptionInSelectForMainSkill [
	<gtExample>
	<after: #clearUnitOfWork>
	| component selectComponent expectedHtml |
	selectComponent := self selectForMainSkill.
	component := selectComponent orderedComponents first.
	self assert: component class equals: LuiSelectOption.
	self assert: component componentName equals: 'mainSkill_1'.
	self assert: component components isEmpty.
	self assert: component model class equals: LxxSkill.
	self assert: component model equals: component valueAccessor read.
	self assert: component text equals: 'Skill 1'.
	expectedHtml := '<option id="214572771" data-name="mainSkill_1" data-StClass="LuiSelectOption" value="1">Skill 1</option>'.
	self assertRendered: component equals: expectedHtml.
	^ component
]

{ #category : 'examples' }
LuiSelectExamples >> newComponent [
	<gtExample>
	| component |
	component := LuiSelect named: 'selectComponent'.
	self assert: component components isEmpty.
	self assert: component parentComponent isNil.
	self assert: component componentName equals: 'selectComponent'.
	self assert: component componentId equals: nil.
	self deny: component hasLabelComponent.
	self assert: component elements isEmpty.
	^ component
]

{ #category : 'examples' }
LuiSelectExamples >> nonslotSelectWithFourOptions [
	<gtExample>
	| component expectedHtml |
	expectedHtml := '<select id="10455883" data-name="selectComponent" data-StClass="LuiSelect" class="inputField" onchange="$.ajax({&quot;url&quot;:&quot;/&quot;,&quot;data&quot;:[&quot;1&quot;,&quot;2=&quot;+encodeURIComponent($(&quot;#10455883&quot;).val())].join(&quot;&amp;&quot;),&quot;success&quot;:function(){$(&quot;#nil&quot;).load(&quot;/&quot;,&quot;3&quot;)}})"><option id="98482473" data-name="selectComponent_1" data-StClass="LuiSelectOption" value="volvo">volvo</option><option id="100146998" data-name="selectComponent_2" data-StClass="LuiSelectOption" value="volkswagen">volkswagen</option><option id="101811523" data-name="selectComponent_3" data-StClass="LuiSelectOption" value="mercedes">mercedes</option><option id="103476048" data-name="selectComponent_4" data-StClass="LuiSelectOption" value="audi">audi</option></select>'.
	component := LuiSelect named: 'selectComponent' model: '' options: #(volvo volkswagen mercedes audi).
	self wrapComponent: component.
	self assert: component componentName equals: 'selectComponent'.
	self deny: component hasLabelComponent.
	self assertRendered: component equals: expectedHtml.
	^ component
]

{ #category : 'examples' }
LuiSelectExamples >> selectForMainSkill [
	<gtExample>
	<after: #clearUnitOfWork>
	| component person |
	LcsApplicationEnvironment ensureCurrentSystemIsPrototypeSystem.
	person := LxxPersonExamples new johnFreeman.
	component := LuiSelect onSlot: (person slotDefinitionNamed: 'mainSkill') model: person.
	self wrapComponent: component.
	self assertRendered: component equals: self expectedHtmlWithFourSkills.
	^ component
]

{ #category : 'examples' }
LuiSelectExamples >> selectSkill1AsMainSkill [
	<gtExample>
	<after: #clearUnitOfWork>
	| component |
	component := self selectForMainSkill.
	component handleCallbackValue: '1'.
	self assert: component valueAccessor read skillName equals: 'Skill 1'.
	^ component
]

{ #category : 'examples' }
LuiSelectExamples >> wrappedNewComponent [
	<gtExample>
	| component expectedHtml |
	expectedHtml := '<select id="10455883" data-name="selectComponent" data-StClass="LuiSelect" class="inputField" onchange="$.ajax({&quot;url&quot;:&quot;/&quot;,&quot;data&quot;:[&quot;1&quot;,&quot;2=&quot;+encodeURIComponent($(&quot;#10455883&quot;).val())].join(&quot;&amp;&quot;),&quot;success&quot;:function(){$(&quot;#nil&quot;).load(&quot;/&quot;,&quot;3&quot;)}})"></select>'.
	component := LuiSelect named: 'selectComponent'.
	self wrapComponent: component.
	self assertRendered: component equals: expectedHtml.
	^ component
]
