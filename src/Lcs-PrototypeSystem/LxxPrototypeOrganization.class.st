Class {
	#name : #LxxPrototypeOrganization,
	#superclass : #LcsDomainObject,
	#instVars : [
		'chiefExecutiveOfficer'
	],
	#category : #'Lcs-PrototypeSystem-Base'
}

{ #category : #'slot definition' }
LxxPrototypeOrganization class >> chiefExecutiveOfficerSlotDefinition [
	<slotDefinition>
	^ LcsMemberOfSlot new
		slotName: 'chiefExecutiveOfficer';
		collectionSlotName: 'persons';
		collectionSlotModuleName: LxxPrototypePersonsModule moduleName;
		addSlotType: LxxPrototypePerson;
		addSlotType: UndefinedObject;
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
