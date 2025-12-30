Class {
	#name : 'LcsBasePerson',
	#superclass : 'LcsLegalEntity',
	#instVars : [
		'dateOfBirth',
		'firstName',
		'middleNames',
		'gender',
		'title',
		'familyName'
	],
	#category : 'Lcs-LegalEntities',
	#package : 'Lcs-LegalEntities'
}

{ #category : 'slot definitions' }
LcsBasePerson class >> dateOfBirthSlotDefinition [
	<accessorSlotDefinition>
	^ LcsDateOfBirthSlot new
]

{ #category : 'slot definitions' }
LcsBasePerson class >> familyNameSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'familyName';
		yourself
]

{ #category : 'slot definitions' }
LcsBasePerson class >> firstNameSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'firstName';
		yourself
]

{ #category : 'slot definitions' }
LcsBasePerson class >> genderSlotDefinition [
	<accessorSlotDefinition>
	^ LcsMemberOfGlobalCollectionSlot new
		slotName: 'gender';
		addSlotType: LcsGender;
		collectionSlotName: 'genders';
		collectionSlotModuleName: LcsLegalEntitiesModule defaultModuleName;
		prevalidationTransformBlock: [ :value :slot | 
			slot targetCollection
				findWithKey: value
				ifNone: [ slot targetCollection defaultInstance ] ];
		yourself
]

{ #category : 'slot definitions' }
LcsBasePerson class >> homeAddressSlotDefinition [
	<facadeSlotDefinition>
	^ LcsInstanceInLocalCollectionSlot new
			slotName: 'homeAddress';
			addSlotType: LcsAddress;
			targetSlotPath: #(#addressType #code) asOrderedCollection;
			collectionSlotName: 'postalAddresses';
			targetItem: 'home';
			yourself
]

{ #category : 'slot definitions' }
LcsBasePerson class >> homeEmailAddressSlotDefinition [
	<facadeSlotDefinition>
	^ LcsInstanceInLocalCollectionSlot new
			slotName: 'homeEmailAddress';
			addSlotType: LcsEmailAddress;
			required: false;
			targetItem: 'home';
			targetSlotPath: #(emailAddressType code) asOrderedCollection;
			collectionSlotName: 'emailAddresses';
			yourself
]

{ #category : 'slot definitions' }
LcsBasePerson class >> middleNamesSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'middleNames';
		yourself
]

{ #category : 'security' }
LcsBasePerson class >> securityResourceName [
	^ 'Person'
]

{ #category : 'slot definitions' }
LcsBasePerson class >> titleSlotDefinition [
	<accessorSlotDefinition>
	^ LcsMemberOfGlobalCollectionSlot new
		slotName: 'title';
		addSlotType: LcsTitle;
		collectionSlotName: 'titles';
		collectionSlotModuleName: LcsLegalEntitiesModule defaultModuleName;
		prevalidationTransformBlock: [ :value :slot | slot targetCollection findWithKey: value ifNone: [ value ] ];
		yourself
]

{ #category : 'slot definitions' }
LcsBasePerson class >> workEmailAddressSlotDefinition [
	<facadeSlotDefinition>
	^ LcsInstanceInLocalCollectionSlot new
		slotName: 'workEmailAddress';
		addSlotType: LcsEmailAddress;
		collectionSlotName: 'emailAddresses';
		targetItem: 'work';
		targetSlotPath: #(emailAddressType code) asOrderedCollection;
		initialValueBlock: [ :parentDomainObject :slot | 
			(parentDomainObject perform: slot collectionSlotName asSymbol)
				findItemIn: slot targetSlotPath matching: slot targetItem ];
		yourself
]

{ #category : 'accessing' }
LcsBasePerson >> dateOfBirth [
	^ self slotVarNamed: 'dateOfBirth'
]

{ #category : 'accessing' }
LcsBasePerson >> dateOfBirth: anObject [
	self slotVarNamed: 'dateOfBirth' put: anObject
]

{ #category : 'accessing' }
LcsBasePerson >> familyName [
	^ self slotVarNamed: 'familyName'
]

{ #category : 'accessing' }
LcsBasePerson >> familyName: anObject [
	self slotVarNamed: 'familyName' put: anObject
]

{ #category : 'accessing' }
LcsBasePerson >> firstName [
	^ self slotVarNamed: 'firstName'
]

{ #category : 'accessing' }
LcsBasePerson >> firstName: anObject [
	self slotVarNamed: 'firstName' put: anObject
]

{ #category : 'accessing' }
LcsBasePerson >> fullName [
	^ self firstName , ' ' , self middleNames , ' ' , self familyName
]

{ #category : 'accessing' }
LcsBasePerson >> gender [
	^ self slotVarNamed: 'gender'
]

{ #category : 'accessing' }
LcsBasePerson >> gender: anObject [
	self slotVarNamed: 'gender' put: anObject
]

{ #category : 'accessing' }
LcsBasePerson >> homeAddress [
	^ self slotVarNamed: 'homeAddress'
]

{ #category : 'accessing' }
LcsBasePerson >> homeAddress: anObject [
	self slotVarNamed: 'homeAddress' put: anObject
]

{ #category : 'accessing' }
LcsBasePerson >> homeEmailAddress [
	^ self slotVarNamed: 'homeEmailAddress'
]

{ #category : 'accessing' }
LcsBasePerson >> homeEmailAddress: anObject [
	self slotVarNamed: 'homeEmailAddress' put: anObject
]

{ #category : 'accessing' }
LcsBasePerson >> middleNames [
	^ self slotVarNamed: 'middleNames'
]

{ #category : 'accessing' }
LcsBasePerson >> middleNames: anObject [
	self slotVarNamed: 'middleNames' put: anObject
]

{ #category : 'accessing' }
LcsBasePerson >> title [
	^ self slotVarNamed: 'title'
]

{ #category : 'accessing' }
LcsBasePerson >> title: anObject [
	self slotVarNamed: 'title' put: anObject
]

{ #category : 'accessing' }
LcsBasePerson >> workEmailAddress [
	^ self slotVarNamed: 'workEmailAddress'
]

{ #category : 'accessing' }
LcsBasePerson >> workEmailAddress: anObject [
	self slotVarNamed: 'workEmailAddress' put: anObject
]
