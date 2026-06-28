Class {
	#name : 'LuiPersonFormFunctionalTest',
	#superclass : 'LuiFormFunctionalTest',
	#category : 'Lcs-WebComponentsTests-Functional',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Functional'
}

{ #category : 'testing' }
LuiPersonFormFunctionalTest class >> isLcsFunctionalTest [
	^ self name asString ~= 'LuiFormFunctionalTest'
]

{ #category : 'presenter' }
LuiPersonFormFunctionalTest >> functionTestPresenter [
	self model: LxxPersonExamples new johnFreeman.
	^ (LuiDomainPresenter named: 'personPresenter' model: self model)
		cssClass: 'twoColumnsBySixRows';
		addLabelAndWidgetComponentFor: 'firstName';
			addLabelAndWidgetComponentFor: 'lastName';
			addLabelAndWidgetComponentFor: 'age' widgetClass: LuiNumberInput;
			addLabelAndWidgetComponentFor: 'mainSkill';
			addLabelAndWidgetComponentFor: 'mainSkill' widgetClass: LuiRadioButtons inputComponentName: 'mainSkillRadioButtons';
			addLabelAndWidgetComponentFor: 'balance';
			addLabelAndWidgetComponentFor: 'skills' widgetClass: LuiMultipleSelect;
		addLabelAndWidgetComponentFor: 'hasRedHair' widgetClass: LuiCheckboxAndLabel;
		addLabelAndWidgetComponentFor: 'dateOfBirth';
			addLabelAndWidgetComponentFor: 'weight';
			addLabelAndWidgetComponentFor: 'weight' widgetClass: LuiRangeInput inputComponentName: 'weightRange';
		addLabelAndWidgetComponentFor: 'comment'

]
