Class {
	#name : 'LuiSelectExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiSelectExamples >> newComponent [
	<gtExample>
	| component expectedHtml |
	expectedHtml := '<select id="nil" data-name="selectComponent" data-StClass="LuiSelect" name="1"></select>'.
	component := LuiSelect named: 'selectComponent'.
	self assert: component components isEmpty.
	self assert: component parentComponent isNil.
	self assert: component componentName equals: 'selectComponent'.
	self assert: component componentId equals: nil.
	self deny: component hasLabelComponent.
	self assertRendered: component equals: expectedHtml.
	^ component
]

{ #category : 'examples' }
LuiSelectExamples >> selectForMainSkill [
	<gtExample>
	<after: #clearUnitOfWork>
	| component expectedHtml person |
	LcsApplicationEnvironment ensureCurrentSystemIsPrototypeSystem.
	person := LxxPersonExamples new johnFreeman.
	component := LuiSelect onSlot: (person slotDefinitionNamed: 'mainSkill') model: person.
	expectedHtml := '<select data-name="mainSkill" data-StClass="LuiSelect" name="1"><option id="99659423" data-name="option_unknown" data-StClass="LuiOption" value="unknown" label=""></option><option id="84194656" data-name="option_1" data-StClass="LuiOption" value="1" label="Skill 1"></option><option id="85859181" data-name="option_2" data-StClass="LuiOption" value="2" label="Skill 2"></option><option id="87523706" data-name="option_3" data-StClass="LuiOption" value="3" label="Skill 3"></option></select>'.
	"self assertRendered: component equals: expectedHtml."
	^ component
]

{ #category : 'examples' }
LuiSelectExamples >> selectWithFourOptions [
	<gtExample>
	| component expectedHtml |
	expectedHtml := '<select id="nil" data-name="selectComponent" data-StClass="LuiSelect" name="1"><option id="258131601" data-name="selectComponent_1" data-StClass="LuiSelect" label="volvo" value="2">volvo</option><option id="259796126" data-name="selectComponent_2" data-StClass="LuiSelect" label="volkswagen" value="3">volkswagen</option><option id="261460651" data-name="selectComponent_3" data-StClass="LuiSelect" label="mercedes" value="4">mercedes</option><option id="263125176" data-name="selectComponent_4" data-StClass="LuiSelect" label="audi" value="5">audi</option></select>'.
	component := LuiSelect named: 'selectComponent'.
	component addOptionsFrom: #(volvo volkswagen mercedes audi).
	self assert: component parentComponent isNil.
	self assert: component componentName equals: 'selectComponent'.
	self assert: component componentId equals: nil.
	self deny: component hasLabelComponent.
	self assertRendered: component equals: expectedHtml.
	^ component
]
