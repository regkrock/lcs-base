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
	^ self
]
