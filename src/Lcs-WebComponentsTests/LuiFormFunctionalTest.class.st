Class {
	#name : 'LuiFormFunctionalTest',
	#superclass : 'LuiFunctionalTest',
	#instVars : [
		'person'
	],
	#category : 'Lcs-WebComponentsTests-Functional',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Functional'
}

{ #category : 'initialize' }
LuiFormFunctionalTest >> initialize [
	| personPresenter form |
	super initialize.
	LcsApplicationEnvironment ensureCurrentSystemIsPrototypeSystem.
	self person ifNil: [ 
		self person: LxxPersonExamples new johnFreeman.
		self person
			dateOfBirth: (Date
					newDay: 2
					month: 8
					year: 1955) ].
	self componentName: 'root'.
	self componentId: 'root'.
	personPresenter := (LuiDomainPresenter named: 'personPresenter')
			cssClass: 'twoColumnsBySixRows';
			model: self person;
			yourself.
	form := LuiMainForm newWith: personPresenter.
	self addComponent: form.
	form addComponent: LuiSaveAndCancelButtonBar new.

	personPresenter 
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
		addLabelAndWidgetComponentFor: 'comment'.
		
]

{ #category : 'accessing' }
LuiFormFunctionalTest >> person [
	^ person
]

{ #category : 'accessing' }
LuiFormFunctionalTest >> person: anObject [
	person := anObject
]

{ #category : 'rendering' }
LuiFormFunctionalTest >> renderComponentOn: html [
	super renderComponentOn: html
]
