Class {
	#name : 'LuiLxxPersonFormTest',
	#superclass : 'LuiRoot',
	#instVars : [
		'model'
	],
	#category : 'Lcs-WebComponentsTests-Functional',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Functional'
}

{ #category : 'register' }
LuiLxxPersonFormTest class >> initialize [
	self registerApplication: 'LxxPersonForm'
]

{ #category : 'presenter' }
LuiLxxPersonFormTest >> functionTestPresenter [
	self model: LxxPersonExamples new johnFreeman.
	^ (LuiDomainPresenter named: 'personPresenter' model: self model)
		cssClass: 'twoColumnsBySixRows';
		addLabelAndWidgetComponentFor: 'firstName';
		addLabelAndWidgetComponentFor: 'lastName';
		"addLabelAndWidgetComponentFor: 'age' widgetClass: LuiNumberInput;"
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

{ #category : 'as yet unclassified' }
LuiLxxPersonFormTest >> initialize [
	| form |
	super initialize.
	LcsApplicationEnvironment ensureCurrentSystemIsPrototypeSystem.
	self componentName: 'root'.
	self componentId: 'root'.
	form := self addComponent: LuiMainForm new.
	form addComponent: self functionTestPresenter.
	form addComponent: LuiSaveAndCancelButtonBar new
]

{ #category : 'accessing' }
LuiLxxPersonFormTest >> model [
	^ model 
]

{ #category : 'accessing' }
LuiLxxPersonFormTest >> model: anObject [ 
	model := anObject
]
