Class {
	#name : 'LuiRadioButtonsExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'private' }
LuiRadioButtonsExamples >> expectedHtmlForMainSkills [
	^ '<div data-name="mainSkill" data-StClass="LuiRadioButtons" class="radioButtons"><input name="1" id="nil_1" checked value="1" type="radio"/><label id="nil_1_Label" for="nil_1"></label><input name="1" id="nil_2" value="2" type="radio"/><label id="nil_2_Label" for="nil_2">Skill 1</label><input name="1" id="nil_3" value="3" type="radio"/><label id="nil_3_Label" for="nil_3">Skill 2</label><input name="1" id="nil_4" value="4" type="radio"/><label id="nil_4_Label" for="nil_4">Skill 3</label></div>'
]

{ #category : 'examples' }
LuiRadioButtonsExamples >> mainSkillsRadioGroup [
	<gtExample>
	<after: #clearUnitOfWork>
	| component person callbackBlock expectedHtml |
	
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
