Class {
	#name : 'LuiRadioButtonsExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'private' }
LuiRadioButtonsExamples >> expectedHtmlForMainSkills [
	^ '<div id="196216916" data-name="mainSkill" data-StClass="LuiRadioButtons" class="radioButtons"><input name="1" id="196216916_1" value="1" type="radio"/><label id="196216916_1_Label" for="196216916_1">Skill 1</label><input name="1" id="196216916_2" value="2" type="radio"/><label id="196216916_2_Label" for="196216916_2">Skill 2</label><input name="1" id="196216916_3" value="3" type="radio"/><label id="196216916_3_Label" for="196216916_3">Skill 3</label><input name="1" id="196216916_4" checked value="4" type="radio"/><label id="196216916_4_Label" for="196216916_4">unknown</label></div>'
]

{ #category : 'examples' }
LuiRadioButtonsExamples >> mainSkillsRadioGroup [
	<gtExample>
	<after: #clearUnitOfWork>
	| component person |
	
	self ensureCurrentSystemIsPrototypeSystem.
	person := LxxPerson new.
	
	component := (LuiRadioButtons 
			onSlotNamed: 'mainSkill' 
			model: person).
	self assert: component componentName equals: 'mainSkill'.
	self assert: component selected skillCode equals: 'unknown'.
	^ component
]

{ #category : 'examples' }
LuiRadioButtonsExamples >> mainSkillsRadioGroupHtml [
	<gtExample>
	<after: #clearUnitOfWork>
	| component expectedHtml |
	component := self mainSkillsRadioGroup.
	self wrapComponent: component.
	expectedHtml := self expectedHtmlForMainSkills.	
	self assertRendered: component equals: expectedHtml.
	^ component
]

{ #category : 'examples' }
LuiRadioButtonsExamples >> mainSkillsRadioGroupWithCallback [
	<gtExample>
	<after: #clearUnitOfWork>
	| component |
	component := self mainSkillsRadioGroup.
	self assert: component callbackBlock printString equals: '[ :value | self handleCallbackValue: value ]'.
	^ component
]
