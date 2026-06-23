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
		addComponent: (LuiLabelWithInputComponent onSlotNamed: 'firstName' model: self person).
	personPresenter
		addComponent: (LuiLabelWithInputComponent onSlotNamed: 'lastName' model: self person).
	personPresenter
		addComponent: (LuiLabelWithInputComponent
				onSlotNamed: 'mainSkill'
				model: self person
				widgetClass: LuiRadioButtons
				componentNamePrefix: 'mainSkillRadio').
	"personPresenter addComponent: (LuiLabelWithInputComponent onSlotNamed: 'mainSkill' model: self person)."
	personPresenter addComponent: (LuiLabelWithInputComponent onSlotNamed: 'age' model: self person widgetClass: LuiNumberInput).
	personPresenter addComponent: (
		LuiLabelWithInputComponent 
			onSlotNamed: 'skills'
			model: self person
			widgetClass: LuiMultipleSelect
			componentNamePrefix: 'skillsSelect').
	personPresenter
		addComponent: (LuiLabelWithInputComponent
				onSlotNamed: 'hasRedHair'
				model: self person
				widgetClass: LuiCheckboxAndLabel
				componentNamePrefix: 'hasRedHair').
	personPresenter
		addComponent: (LuiLabelWithInputComponent onSlotNamed: 'dateOfBirth' model: self person)
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
