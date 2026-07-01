Class {
	#name : 'LcsEmailAddress',
	#superclass : 'LcsDomainObject',
	#traits : 'LtDateRange',
	#classTraits : 'LtDateRange classTrait',
	#instVars : [
		'email',
		'emailAddressType'
	],
	#category : 'Lcs-LegalEntities-Core',
	#package : 'Lcs-LegalEntities',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsEmailAddress class >> emailAddressTypeSlotDefinition [
	<accessorSlotDefinition>
	^ LcsMemberOfGlobalCollectionSlot new
		addSlotType: LcsEmailAddressType;
		slotName: 'emailAddressType';
		prevalidationTransformBlock: [ :value :slot | slot targetCollection findItemMatchingCode: value ifNone: [ value ] ];
		collectionSlotName: 'emailAddressTypes';
		collectionSlotModuleName: LcsLegalEntitiesModule defaultModuleName;
		yourself
]

{ #category : 'slot definitions' }
LcsEmailAddress class >> emailRegexPattern [
	"This pattern is from https://regex-snippets.com/email. Raw string is in next comment.
	"
	"^(?!\.)(?!.*\.\.)(?!.*\.@)[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@(?!-)[a-zA-Z0-9-]+(?<!-)(?:\.[a-zA-Z0-9-]+(?<!-))*\.[a-zA-Z]{2,}$"
	| stream |
	stream := WriteStream on: String new.
	^ stream 
		nextPutAll: '(?!\.)(?!.*\.\.)(?!.*\.@)[a-zA-Z0-9.!#$%&';
		nextPut: $';
		nextPutAll: '*+/=?^_`{|}~-]+@(?!-)[a-zA-Z0-9-]+(?<!-)(?:\.[a-zA-Z0-9-]+(?<!-))*\.[a-zA-Z]{2,}';
		contents
]

{ #category : 'slot definitions' }
LcsEmailAddress class >> emailSlotDefinition [
	<accessorSlotDefinition>
	| slot |
	slot := LcsStringSlot new
		slotName: 'email';
		addValidationRuleBlock: [ :value :parentDomainObject :oldValue | value matchesRegex: slot pattern ]
			description: 'Invalid email'
			errorMessage: 'Malformed email address';
		pattern: self emailRegexPattern;
		yourself.
	^ slot
]

{ #category : 'slot definitions' }
LcsEmailAddress class >> parentSlotDefinition [
	<accessorSlotDefinition>
	^ super parentSlotDefinition	"^ LcsGlobalCollectionReferenceSlot new
			slotTypes: (OrderedCollection with: LcsEmailAddresses);
			slotName: 'parent';
			collectionSlotName: 'emailAddresses';
			collectionSlotModuleName: 'Legal Entities Module';
			yourself"
]

{ #category : 'accessing' }
LcsEmailAddress >> email [
	^ self slotVarNamed: 'email'
]

{ #category : 'accessing' }
LcsEmailAddress >> email: anObject [
	self slotVarNamed: 'email' put: anObject
]

{ #category : 'accessing' }
LcsEmailAddress >> emailAddressType [
	^ self slotVarNamed: 'emailAddressType'
]

{ #category : 'accessing' }
LcsEmailAddress >> emailAddressType: anObject [
	self slotVarNamed: 'emailAddressType' put: anObject
]
