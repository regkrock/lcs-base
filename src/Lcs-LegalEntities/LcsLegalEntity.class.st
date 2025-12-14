Class {
	#name : 'LcsLegalEntity',
	#superclass : 'LcsDomainObject',
	#instVars : [
		'emailAddresses',
		'postalAddresses',
		'phoneNumbers'
	],
	#category : 'Lcs-LegalEntities',
	#package : 'Lcs-LegalEntities'
}

{ #category : 'slot definitions' }
LcsLegalEntity class >> emailAddressesSlotDefinition [
	<slotDefinition>
	^ LcsLocalCollectionSlot new
		slotName: 'emailAddresses';
		addSlotType: LcsEmailAddresses;
		addCollectionMemberType: LcsEmailAddress;
		addPostAddAction: (LcsPostAddAction new
				description: 'Add to global collection';
				actionBlock: [ :newValue :parentDomainObject :oldValue | 
					(parentDomainObject currentSystem moduleNamed: LcsLegalEntitiesModule defaultModuleName)
						emailAddresses add: newValue ]);
		addPostRemoveAction: (LcsPostRemoveAction new
				description: 'Remove from global collection';
				actionBlock: [ :newValue :parentDomainObject :oldValue | 
					(parentDomainObject currentSystem moduleNamed: LcsLegalEntitiesModule defaultModuleName)
						emailAddresses remove: newValue ]);
		yourself
]

{ #category : 'slot definitions' }
LcsLegalEntity class >> entityNameSlotDefinition [
	<virtualSlotDefinition>
	^ LcsVirtualSlot new
			slotName: 'entityName';
			valueAccessor: #fullName;
			yourself
]

{ #category : 'slot definitions' }
LcsLegalEntity class >> phoneNumbersSlotDefinition [
	<slotDefinition>
	^ LcsLocalCollectionSlot new
			slotName: 'phoneNumbers';
			addSlotType: LcsPhoneNumbers;
			addCollectionMemberType: LcsPhoneNumber;
			addPostAddAction: (LcsPostAddAction new
				description: 'Add to global collection';
				actionBlock: [ :newValue :parentDomainObject :oldValue | 
					(parentDomainObject currentSystem moduleNamed: LcsLegalEntitiesModule defaultModuleName)
						phoneNumbers add: newValue ]);
		addPostRemoveAction: (LcsPostRemoveAction new
				description: 'Remove from global collection';
				actionBlock: [ :newValue :parentDomainObject :oldValue | 
					(parentDomainObject currentSystem moduleNamed: LcsLegalEntitiesModule defaultModuleName)
						phoneNumbers remove: newValue ]);
			yourself
]

{ #category : 'slot definitions' }
LcsLegalEntity class >> postalAddressesSlotDefinition [
	<slotDefinition>
	^ LcsLocalCollectionSlot new
		slotName: 'postalAddresses';
		addSlotType: LcsAddresses;
		addCollectionMemberType: LcsAddress;
		addPostAddAction: (LcsPostAddAction new
				description: 'Add address to the global addresses collection';
				actionBlock: [ :newValue :parentDomainObject :oldValue | 
					(parentDomainObject currentSystem moduleNamed: LcsGeographyModule defaultModuleName) addresses
						add: newValue ]);
		addPostRemoveAction: (LcsPostRemoveAction new
				description: 'Remove from global collection';
				actionBlock: [ :newValue :parentDomainObject :oldValue | 
					(parentDomainObject currentSystem moduleNamed: LcsGeographyModule defaultModuleName)
						addresses remove: newValue ]);
		yourself
]

{ #category : 'as yet unclassified' }
LcsLegalEntity >> contactWithFirstName: aFirstName familyName: aFamilyName [
	^ self currentSystem legalEntitiesModule contactWithFirstName: aFirstName familyName: aFamilyName
]

{ #category : 'accessing' }
LcsLegalEntity >> emailAddresses [
	^ self slotVarNamed: 'emailAddresses'
]

{ #category : 'accessing' }
LcsLegalEntity >> emailAddresses: anObject [
	self slotVarNamed: 'emailAddresses' put: anObject
]

{ #category : 'accessing' }
LcsLegalEntity >> entityName [
	^ self virtualSlotVarNamed: 'entityName'
]

{ #category : 'as yet unclassified' }
LcsLegalEntity >> hasContactWithFirstName: aFirstName familyName: aFamilyName [
	^ self currentSystem legalEntitiesModule hasContactWithFirstName: aFirstName familyName: aFamilyName
]

{ #category : 'accessing' }
LcsLegalEntity >> phoneNumbers [
	^ self slotVarNamed: 'phoneNumbers'
]

{ #category : 'accessing' }
LcsLegalEntity >> phoneNumbers: anObject [
	self slotVarNamed: 'phoneNumbers' put: anObject
]

{ #category : 'accessing' }
LcsLegalEntity >> postalAddresses [
	^ self slotVarNamed: 'postalAddresses'
]

{ #category : 'accessing' }
LcsLegalEntity >> postalAddresses: anObject [
	self slotVarNamed: 'postalAddresses' put: anObject
]
