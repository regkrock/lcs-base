Class {
	#name : #LcsStringSlotTest,
	#superclass : #LcsDomainTestCase,
	#category : #'Lcs-BarebonesSystemTests'
}

{ #category : #setUp }
LcsStringSlotTest >> setupSunitSystem [
	LxxBarebonesSystem new
]

{ #category : #accessing }
LcsStringSlotTest >> tearDown [
	super tearDown.

	(LxxBarebonesPerson instVarNames includes: 'firstName')
		ifTrue: [LxxBarebonesPerson removeInstVarNamed: 'firstName'].
	(LxxBarebonesPerson canUnderstand: #firstName)
		ifTrue: [LxxBarebonesPerson removeSelector: #'firstName'].
	(LxxBarebonesPerson canUnderstand: #firstName:)
		ifTrue: [LxxBarebonesPerson removeSelector: #'firstName:'].
	(LxxBarebonesPerson class canUnderstand: #firstNameSlotDefinition)
		ifTrue: [LxxBarebonesPerson class removeSelector: #firstNameSlotDefinition].
		
	self deny: (LxxBarebonesPerson instVarNames includes: 'firstName').
	self deny: (LxxBarebonesPerson canUnderstand: #firstName).
	self deny: (LxxBarebonesPerson canUnderstand: #firstName:).
	self deny: (LxxBarebonesPerson class canUnderstand: #firstNameSlotDefinition).


]

{ #category : #accessing }
LcsStringSlotTest >> testInstallingFirstNameSlotInPerson [
	| builder |
	self deny: (LxxBarebonesPerson instVarNames includes: 'firstName').
	self deny: (LxxBarebonesPerson canUnderstand: #firstName).
	self deny: (LxxBarebonesPerson canUnderstand: #firstName:).
	self deny: (LxxBarebonesPerson class canUnderstand: #firstNameSlotDefinition).

	builder := LcsStringSlotDefinitionBuilder new
		targetClassName: 'LxxBarebonesPerson';
		slotName: 'firstName'.
		
	self assert: builder slotName equals: 'firstName'.
	self assert: builder targetClassName equals: 'LxxBarebonesPerson'.
	self assert: builder target equals: LxxBarebonesPerson.
	self assert: builder slotDefinitionSelector equals: 'firstNameSlotDefinition'.	
	
	builder install.
		
	self assert: (LxxBarebonesPerson instVarNames includes: 'firstName').
	self assert: (LxxBarebonesPerson canUnderstand: #'firstName').
	self assert: (LxxBarebonesPerson canUnderstand: #firstName:).
	self assert: (LxxBarebonesPerson class canUnderstand: #firstNameSlotDefinition).

]
