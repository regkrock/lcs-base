Class {
	#name : 'LuiFormFunctionalTest',
	#superclass : 'LuiFunctionalTest',
	#category : 'Lcs-WebComponentsTests-Functional',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Functional'
}

{ #category : 'initialize' }
LuiFormFunctionalTest >> initialize [
	| personPresenter person |
	super initialize.

	LcsApplicationEnvironment ensureCurrentSystemIsPrototypeSystem.

	person := LxxPersonExamples new johnFreeman.
	person dateOfBirth: (Date newDay: 2 month: 8 year: 1955).

	self componentName: 'root'.
	self componentId: 'root'.
	self addComponent: (
		LuiForm newWith: (
			(LuiDomainPresenter named: 'personPresenter')
				cssClass: 'mainForm';
				model: person;
				yourself)).
	personPresenter := self componentNamed: 'form/personPresenter'.

	personPresenter addComponent: (LuiLabelWithInputComponent onSlot: (person slotDefinitionNamed: 'firstName') model: person).
	personPresenter addComponent: (LuiLabelWithInputComponent onSlot: (person slotDefinitionNamed: 'lastName') model: person).
	personPresenter addComponent: (LuiLabelWithInputComponent onSlot: (person slotDefinitionNamed: 'mainSkill') model: person).
	personPresenter addComponent: (
		LuiLabelWithInputComponent 
			onSlot: (person slotDefinitionNamed: 'mainSkill') 
			model: person
			widgetClass: LuiRadioButtons
			componentName: 'mainSkillRadio').
	personPresenter addComponent: (
		LuiLabelWithInputComponent 
			onSlot: (person slotDefinitionNamed: 'skills') 
			model: person
			widgetClass: LuiMultipleSelect
			componentName: 'skillsSelect').
	personPresenter addComponent: (
		LuiLabelWithInputComponent 
			onSlot: (person slotDefinitionNamed: 'hasRedHair') 
			model: person
			widgetClass: LuiCheckbox
			componentName: 'hasRedHair').
]
