Class {
	#name : 'LuiMultiselectExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'private' }
LuiMultiselectExamples >> expectedHtmlWithFourSkills [
	^ '<select id="87136682" data-name="skills" data-StClass="LuiMultiselect" onblur="$.ajax({&quot;url&quot;:&quot;/&quot;,&quot;data&quot;:[&quot;1&quot;,&quot;2=&quot;+encodeURIComponent($(&quot;#87136682&quot;).val())].join(&quot;&amp;&quot;),&quot;success&quot;:function(){$(&quot;#nil&quot;).load(&quot;/&quot;,&quot;3&quot;)}})" multiple><option id="258749723" data-name="skills_1" data-StClass="LuiSelectOption" value="unknown"></option><option id="260414248" data-name="skills_2" data-StClass="LuiSelectOption" value="1">Skill 1</option><option id="262078773" data-name="skills_3" data-StClass="LuiSelectOption" value="2">Skill 2</option><option id="263743298" data-name="skills_4" data-StClass="LuiSelectOption" value="3">Skill 3</option></select>'
]

{ #category : 'examples' }
LuiMultiselectExamples >> firstOptionInSelectForSkills [
	<gtExample>
	<after: #clearUnitOfWork>
	| component selectComponent expectedHtml |
	selectComponent := self selectForSkills.
	component := selectComponent orderedComponents first.
	self assert: component class equals: LuiSelectOption.
	self assert: component componentName equals: 'skills_1'.
	self assert: component components isEmpty.
	self assert: component model class equals: LxxUnknownSkill.
	self assert: component model equals: component valueAccessor read.
	self assert: component text equals: ''.
	expectedHtml := '<option id="258749723" data-name="skills_1" data-StClass="LuiSelectOption" value="unknown"></option>'.
	self assertRendered: component equals: expectedHtml.
	^ component
]

{ #category : 'examples' }
LuiMultiselectExamples >> multiselectOnNonSlotList [
	<gtExample>
	| component expectedHtml |
	expectedHtml := '<select id="10455883" data-name="selectComponent" data-StClass="LuiSelect" name="1"><option id="258131601" data-name="selectComponent_1" data-StClass="LuiSelect" label="volvo" value="2">volvo</option><option id="259796126" data-name="selectComponent_2" data-StClass="LuiSelect" label="volkswagen" value="3">volkswagen</option><option id="261460651" data-name="selectComponent_3" data-StClass="LuiSelect" label="mercedes" value="4">mercedes</option><option id="263125176" data-name="selectComponent_4" data-StClass="LuiSelect" label="audi" value="5">audi</option></select>'.
	component := LuiMultiselect named: 'selectComponent' model: OrderedCollection new options: #(volvo volkswagen mercedes audi) .
	self wrapComponent: component.
	self assert: component componentName equals: 'selectComponent'.
	self deny: component hasLabelComponent.
	"self assertRendered: component equals: expectedHtml."
	^ component
]

{ #category : 'examples' }
LuiMultiselectExamples >> newComponent [
	<gtExample>
	| component |
	component := LuiMultiselect named: 'selectComponent'.
	self assert: component components isEmpty.
	self assert: component parentComponent isNil.
	self assert: component componentName equals: 'selectComponent'.
	self assert: component componentId equals: nil.
	self deny: component hasLabelComponent.
	self assert: component elements isEmpty.
	^ component
]

{ #category : 'examples' }
LuiMultiselectExamples >> selectForSkills [
	<gtExample>
	<after: #clearUnitOfWork>
	| component person |
	LcsApplicationEnvironment ensureCurrentSystemIsPrototypeSystem.
	person := LxxPersonExamples new johnFreeman.
	component := LuiMultiselect onSlot: (person slotDefinitionNamed: 'skills') model: person.
	self assert: component valueAccessor read class equals: LxxSubsetSkills.
	self assert: component model == person.
	self assert: component valueAccessor readSelector equals: #skills.
	self assert: component valueAccessor read hasNoElements.
	self assert: component orderedComponents first model skillCode equals: 'unknown'.
	self assert: component orderedComponents first valueAccessor read skillCode equals: 'unknown'.
	self wrapComponent: component.
	self assertRendered: component equals: self expectedHtmlWithFourSkills.
	^ component
]

{ #category : 'examples' }
LuiMultiselectExamples >> selectSkill1AndSkill2AndAddToEmptyTargetCollection [
	<gtExample>
	<after: #clearUnitOfWork>
	| component skillsCollection |
	component := self selectForSkills.
	skillsCollection := component valueAccessor read.
	self assert: skillsCollection actualCollection size = 0.
	component handleCallbackValue: '1,2'.
	self assert: skillsCollection actualCollection size = 2.
	self assert: (skillsCollection find: [ :each | each skillName = 'Skill 1']) notNil .
	self assert: (skillsCollection find: [ :each | each skillName = 'Skill 2']) notNil .
	^ component
]

{ #category : 'examples' }
LuiMultiselectExamples >> selectSkill1AndSkill3AndAddToTargetCollectionWithSkill1AndSkill2 [
	<gtExample>
	<after: #clearUnitOfWork>
	| component skillsCollection |
	component := self selectSkill1AndSkill2AndAddToEmptyTargetCollection.
	skillsCollection := component valueAccessor read.
	self assert: skillsCollection actualCollection size = 2.
	component handleCallbackValue: '1,3'.
	self assert: skillsCollection actualCollection size = 2.
	self assert: (skillsCollection find: [ :each | each skillName = 'Skill 1']) notNil .
	self assert: (skillsCollection find: [ :each | each skillName = 'Skill 3']) notNil .
	^ component
]

{ #category : 'examples' }
LuiMultiselectExamples >> wrappedNewComponent [
	<gtExample>
	| component expectedHtml |
	expectedHtml := '<select id="10455883" data-name="selectComponent" data-StClass="LuiMultiselect" onblur="$.ajax({&quot;url&quot;:&quot;/&quot;,&quot;data&quot;:[&quot;1&quot;,&quot;2=&quot;+encodeURIComponent($(&quot;#10455883&quot;).val())].join(&quot;&amp;&quot;),&quot;success&quot;:function(){$(&quot;#nil&quot;).load(&quot;/&quot;,&quot;3&quot;)}})" multiple></select>'.
	component := self newComponent.
	self wrapComponent: component.
	self assertRendered: component equals: expectedHtml.
	^ component
]
