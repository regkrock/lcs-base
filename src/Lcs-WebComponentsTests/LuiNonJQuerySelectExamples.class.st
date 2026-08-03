Class {
	#name : 'LuiNonJQuerySelectExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiNonJQuerySelectExamples >> newComponent [
	<gtExample>
	| component expectedHtml |
	expectedHtml := '<select id="" data-name="selectComponent" data-StClass="LuiNonJQuerySelect" class="inputField" name="2"></select>'.
	component := LuiNonJQuerySelect named: 'selectComponent'.
	self assert: component components isEmpty.
	self assert: component parentComponent isNil.
	self assert: component componentName equals: 'selectComponent'.
	self assert: component componentId equals: nil.
	self deny: component hasLabelComponent.
	"self assertRendered: component equals: expectedHtml."
	^ component
]

{ #category : 'examples' }
LuiNonJQuerySelectExamples >> selectForMainSkill [
	<gtExample>
	<after: #clearUnitOfWork>
	| component expectedHtml person |
	LcsApplicationEnvironment ensureCurrentSystemIsPrototypeSystem.
	person := LxxPersonExamples new johnFreeman.
	component := LuiNonJQuerySelect onSlot: (person slotDefinitionNamed: 'mainSkill') model: person.
	expectedHtml := '<select id="" data-name="mainSkill" data-StClass="LuiNonJQuerySelect" class="inputField" name="2"><option id="156857547" data-name="mainSkill_1" data-StClass="LuiNonJQuerySelect" label="Skill 1">1</option><option id="158522072" data-name="mainSkill_2" data-StClass="LuiNonJQuerySelect" label="Skill 2">2</option><option id="160186597" data-name="mainSkill_3" data-StClass="LuiNonJQuerySelect" label="Skill 3">3</option><option id="161851122" data-name="mainSkill_4" data-StClass="LuiNonJQuerySelect" label="unknown" selected>unknown</option></select>'.
	self assertRendered: component equals: expectedHtml.
	^ component
]

{ #category : 'examples' }
LuiNonJQuerySelectExamples >> selectWithFourOptions [
	<gtExample>
	| component expectedHtml |
	expectedHtml := '<select id="" data-name="selectComponent" data-StClass="LuiNonJQuerySelect" class="inputField" name="2"><option id="258131601" data-name="selectComponent_1" data-StClass="LuiNonJQuerySelect" label="volvo">volvo</option><option id="259796126" data-name="selectComponent_2" data-StClass="LuiNonJQuerySelect" label="volkswagen">volkswagen</option><option id="261460651" data-name="selectComponent_3" data-StClass="LuiNonJQuerySelect" label="mercedes">mercedes</option><option id="263125176" data-name="selectComponent_4" data-StClass="LuiNonJQuerySelect" label="audi">audi</option></select>'.
	component := LuiNonJQuerySelect named: 'selectComponent'.
	component elements: #(volvo volkswagen mercedes audi).
	self assert: component parentComponent isNil.
	self assert: component componentName equals: 'selectComponent'.
	self assert: component componentId equals: nil.
	self deny: component hasLabelComponent.
	self assertRendered: component equals: expectedHtml.
	^ component
]
