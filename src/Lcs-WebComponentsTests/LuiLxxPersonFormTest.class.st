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
	| presenter |
	self model: LxxPersonExamples new johnFreeman.
	presenter := (LuiDomainPresenter named: 'personPresenter' model: self model)
		cssClass: 'twoColumnsBySixRows';
		addLabelAndWidgetComponentFor: 'firstName';
		addLabelAndWidgetComponentFor: 'lastName';
		addLabelAndWidgetComponentFor: 'age' widgetClass: LuiNumberInput;
		addLabelAndWidgetComponentFor: 'mainSkill';
		addLabelAndWidgetComponentFor: 'mainSkill' widgetClass: LuiRadioButtonsGroup inputComponentName: 'mainSkillRadioButtons';
		addLabelAndWidgetComponentFor: 'balance';
		addLabelAndWidgetComponentFor: 'skills' widgetClass: LuiMultiselect;
		addLabelAndWidgetComponentFor: 'hasRedHair' widgetClass: LuiCheckboxAndLabel;
		addLabelAndWidgetComponentFor: 'dateOfBirth';
		addLabelAndWidgetComponentFor: 'weight';
		addLabelAndWidgetComponentFor: 'weight' widgetClass: LuiRangeInput inputComponentName: 'weightRange';
		addLabelAndWidgetComponentFor: 'comment'.

	presenter 
		makeComponentNamed: 'mainSkillLabelAndInput/mainSkill' 
		mututallyDependentOnComponentNamed: 'mainSkillRadioButtonsLabelAndInput/mainSkillRadioButtons'.

	presenter 
		makeComponentNamed: 'weightRangeLabelAndInput/weightRange' 
		mututallyDependentOnComponentNamed: 'weightLabelAndInput/weight'.

	presenter 
		makeComponentNamed: 'ageLabelAndInput/age' 
		dependentOnComponentNamed: 'dateOfBirthLabelAndInput/dateOfBirth'.

	^ presenter

]

{ #category : 'initialize' }
LuiLxxPersonFormTest >> initialize [
	| form |
	super initialize.
	LcsApplicationEnvironment ensureCurrentSystemIsPrototypeSystem.
	self currentUnitOfWork clearUnitOfWork.
	self componentName: 'root'.
	self componentId: 'root'.
	form := self addComponent: LuiMainForm new.
	form addComponent: self functionTestPresenter.
	form addComponent: LuiSaveAndCancelButtonBar new.
	^ self
]

{ #category : 'accessing' }
LuiLxxPersonFormTest >> model [
	^ model 
]

{ #category : 'accessing' }
LuiLxxPersonFormTest >> model: anObject [ 
	model := anObject
]

{ #category : 'rendering' }
LuiLxxPersonFormTest >> renderComponentOn: html [
	super renderComponentOn: html		
]

{ #category : 'initialize' }
LuiLxxPersonFormTest >> updateRoot: aRoot [
	super updateRoot: aRoot.
	aRoot stylesheet url: LcsFunctionalTestFileLibrary / #mainCss
]
