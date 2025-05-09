Class {
	#name : #LxxOrganization,
	#superclass : #LcsDomainObject,
	#instVars : [
		'chiefExecutiveOfficer'
	],
	#category : #'Lcs-PrototypeSystem-Base'
}

{ #category : #'slot definitions' }
LxxOrganization class >> chiefExecutiveOfficerSlotDefinition [
	<slotDefinition>
	^ LcsMemberOfSlot new
		slotName: 'chiefExecutiveOfficer';
		collectionSlotName: 'persons';
		collectionSlotModuleName: LxxPersonsModule defaultModuleName;
		addSlotType: LxxPerson;
		"addSlotType: UndefinedObject;"
		addSlotType: LxxUnknownPerson;
		beRequired;
		yourself
]

{ #category : #accessing }
LxxOrganization >> chiefExecutiveOfficer [
	^ self slotVarNamed: 'chiefExecutiveOfficer'
]

{ #category : #accessing }
LxxOrganization >> chiefExecutiveOfficer: aPerson [
	self slotVarNamed: 'chiefExecutiveOfficer' put: aPerson
]
