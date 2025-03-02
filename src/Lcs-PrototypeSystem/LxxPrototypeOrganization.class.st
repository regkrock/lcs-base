Class {
	#name : #LxxPrototypeOrganization,
	#superclass : #LcsDomainObject,
	#instVars : [
		'chiefExecutiveOfficer'
	],
	#category : #'Lcs-PrototypeSystem-Base'
}

{ #category : #'slot definitions' }
LxxPrototypeOrganization class >> chiefExecutiveOfficerSlotDefinition [
	<slotDefinition>
	^ LcsMemberOfSlot new
		slotName: 'chiefExecutiveOfficer';
		collectionSlotName: 'persons';
		collectionSlotModuleName: LxxPrototypePersonsModule moduleName;
		addSlotType: LxxPrototypePerson;
		addSlotType: UndefinedObject;
		"addSlotType: LxxPrototypeUnknownPerson;"
		beRequired;
		yourself
]

{ #category : #accessing }
LxxPrototypeOrganization >> chiefExecutiveOfficer [
	^ self slotVarNamed: 'chiefExecutiveOfficer'
]

{ #category : #accessing }
LxxPrototypeOrganization >> chiefExecutiveOfficer: aPerson [
	self slotVarNamed: 'chiefExecutiveOfficer' put: aPerson
]
