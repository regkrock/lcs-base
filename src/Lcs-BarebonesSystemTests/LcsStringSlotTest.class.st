Class {
	#name : #LcsStringSlotTest,
	#superclass : #LcsDomainTestCase,
	#category : #'Lcs-BarebonesSystemTests'
}

{ #category : #running }
LcsStringSlotTest >> removeArtifactsRelatedToFirstNameSlot [
	LxxBarebonesPerson removeDomainSlotNamed: 'firstName'.
	LxxBarebonesPerson assertSlotRemoved: 'firstName'.

]

{ #category : #running }
LcsStringSlotTest >> setupSunitSystem [
	LxxBarebonesSystem new
]

{ #category : #running }
LcsStringSlotTest >> tearDown [
	super tearDown.
	self removeArtifactsRelatedToFirstNameSlot
]

{ #category : #tests }
LcsStringSlotTest >> testInstallingFirstNameSlotInPerson [
	| builder |
	self removeArtifactsRelatedToFirstNameSlot.

	builder := LcsStringSlotDefinitionBuilder new
		targetClassName: 'LxxBarebonesPerson';
		slotName: 'firstName'.
		
	self assert: builder slotName equals: 'firstName'.
	self assert: builder targetClassName equals: 'LxxBarebonesPerson'.
	self assert: builder target equals: LxxBarebonesPerson.
	self assert: builder slotDefinitionSelector equals: 'firstNameSlotDefinition'.	

	builder install.
		
	LxxBarebonesPerson assertSlotAdded: 'firstName'.

]
