Class {
	#name : #LcsDomainClassAndDomainCollectionClassBuilderJob,
	#superclass : #LcsCodeBuilderJob,
	#instVars : [
		'classPrefix',
		'targetPackageName',
		'domainInstanceSlotName',
		'classRootName',
		'globalCollectionSlotName',
		'targetDomainClasses',
		'targetModuleName',
		'targetModuleClass',
		'newDomainClassName',
		'globalCollectionModuleClass',
		'globalCollectionClassName'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #builders }
LcsDomainClassAndDomainCollectionClassBuilderJob >> addMemberOfSlotBuilderForTargetClasses [
	self targetDomainClasses
		do: [ :eachClass | self addJobStep: (self memberOfSlotBuilderFor: eachClass) ]
]

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> classPrefix [
	^ classPrefix
]

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> classPrefix: aString [
	classPrefix := aString
]

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> classRootName [
	^ classRootName
]

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> classRootName: aString [
	classRootName := aString
]

{ #category : #configuration }
LcsDomainClassAndDomainCollectionClassBuilderJob >> createForPrefix: aPrefix rootName: aRootName [
	self classPrefix: aPrefix.
	self createForRootName: aRootName
]

{ #category : #configuration }
LcsDomainClassAndDomainCollectionClassBuilderJob >> createForRootName: aRootName [
	self classRootName: aRootName.
	self domainInstanceSlotName: self classRootName asValidSelector.
	self globalCollectionSlotName: self domainInstanceSlotName asEnglishPlural.
	self newDomainClassName: self classPrefix , aRootName.
	self globalCollectionClassName: self newDomainClassName asEnglishPlural
]

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> domainInstanceSlotName [
	^ domainInstanceSlotName
]

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> domainInstanceSlotName: aString [ 
	domainInstanceSlotName := aString
]

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> globalCollectionClassName [
	^ globalCollectionClassName
]

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> globalCollectionClassName: anObject [ 
	globalCollectionClassName := anObject
]

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> globalCollectionModuleClass [
	^ globalCollectionModuleClass
]

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> globalCollectionModuleClass: aClass [
	globalCollectionModuleClass := aClass
]

{ #category : #builders }
LcsDomainClassAndDomainCollectionClassBuilderJob >> globalCollectionReferenceSlotBuilder [
	^ LcsGlobalCollectionReferenceSlotBuilder new
		targetClassName: self newDomainClassName;
		collectionSlotName: self globalCollectionSlotName;
		collectionSlotModuleName: self globalCollectionModuleClass defaultModuleName;
		addSlotType: self globalCollectionClassName;
		yourself
]

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> globalCollectionSlotName [
	^ globalCollectionSlotName
]

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> globalCollectionSlotName: aString [
	globalCollectionSlotName := aString
]

{ #category : #initialize }
LcsDomainClassAndDomainCollectionClassBuilderJob >> initialize [
	super initialize.
	self classPrefix: 'Lcs'.
]

{ #category : #initialize }
LcsDomainClassAndDomainCollectionClassBuilderJob >> installGlobalCollectionSlotInModuleClass: aClass [
	self globalCollectionModuleClass: aClass 
]

{ #category : #configuration }
LcsDomainClassAndDomainCollectionClassBuilderJob >> installMemberSlotInDomainClass: aClass [ 
	self targetDomainClasses add: aClass
]

{ #category : #configuration }
LcsDomainClassAndDomainCollectionClassBuilderJob >> installNewClassesInPackageNamed: aString [ 
	self targetPackageName: aString
]

{ #category : #builders }
LcsDomainClassAndDomainCollectionClassBuilderJob >> memberOfSlotBuilderFor: aTargetClass [ 
	^ LcsMemberOfSlotBuilder new
		targetClassName: aTargetClass name;
		slotName: self domainInstanceSlotName;
		collectionSlotName: self globalCollectionSlotName;
		collectionSlotModuleName: self globalCollectionModuleClass defaultModuleName;
		addSlotType: self newDomainClassName;
		yourself
]

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> newDomainClassName [
	^ newDomainClassName
]

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> newDomainClassName: anObject [ 
	newDomainClassName := anObject
]

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> newGlobalCollectionClassName: anObject [ 
	self globalCollectionClassName: self classPrefix , anObject
]

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> targetDomainClasses [
	^ targetDomainClasses
]

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> targetDomainClasses: aCollection [
	targetDomainClasses := aCollection
]

{ #category : #asking }
LcsDomainClassAndDomainCollectionClassBuilderJob >> targetModule [
	^ self currentSystem moduleNamed: self globalCollectionModuleClass defaultModuleName
]

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> targetModuleClass [
	^ targetModuleClass
]

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> targetModuleClass: aModuleClass [
	targetModuleClass := aModuleClass
]

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> targetModuleName [
	^ targetModuleName
]

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> targetModuleName: aString [
	targetModuleName := aString
]

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> targetPackageName [
	^ targetPackageName
]

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> targetPackageName: aString [ 
	targetPackageName := aString
]
