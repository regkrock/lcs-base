Class {
	#name : #LcsDomainClassWithGlobalCollectionBuilderJob,
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
LcsDomainClassWithGlobalCollectionBuilderJob >> addMemberOfSlotBuilderForTargetClasses [
	self targetDomainClasses
		do: [ :eachClass | self addJobStep: (self memberOfSlotBuilderFor: eachClass) ]
]

{ #category : #accessing }
LcsDomainClassWithGlobalCollectionBuilderJob >> classPrefix [
	^ classPrefix
]

{ #category : #accessing }
LcsDomainClassWithGlobalCollectionBuilderJob >> classPrefix: aString [
	classPrefix := aString
]

{ #category : #accessing }
LcsDomainClassWithGlobalCollectionBuilderJob >> classRootName [
	^ classRootName
]

{ #category : #accessing }
LcsDomainClassWithGlobalCollectionBuilderJob >> classRootName: aString [
	classRootName := aString
]

{ #category : #configuration }
LcsDomainClassWithGlobalCollectionBuilderJob >> createForPrefix: aPrefix rootName: aRootName [
	self classPrefix: aPrefix.
	self createForRootName: aRootName
]

{ #category : #configuration }
LcsDomainClassWithGlobalCollectionBuilderJob >> createForRootName: aRootName [
	self classRootName: aRootName.
	self domainInstanceSlotName: self classRootName asValidSelector.
	self globalCollectionSlotName: self domainInstanceSlotName asEnglishPlural.
	self newDomainClassName: self classPrefix , aRootName.
	self globalCollectionClassName: self newDomainClassName asEnglishPlural
]

{ #category : #accessing }
LcsDomainClassWithGlobalCollectionBuilderJob >> domainInstanceSlotName [
	^ domainInstanceSlotName
]

{ #category : #accessing }
LcsDomainClassWithGlobalCollectionBuilderJob >> domainInstanceSlotName: aString [ 
	domainInstanceSlotName := aString
]

{ #category : #accessing }
LcsDomainClassWithGlobalCollectionBuilderJob >> globalCollectionClassName [
	^ globalCollectionClassName
]

{ #category : #accessing }
LcsDomainClassWithGlobalCollectionBuilderJob >> globalCollectionClassName: anObject [ 
	globalCollectionClassName := anObject
]

{ #category : #accessing }
LcsDomainClassWithGlobalCollectionBuilderJob >> globalCollectionModuleClass [
	^ globalCollectionModuleClass
]

{ #category : #accessing }
LcsDomainClassWithGlobalCollectionBuilderJob >> globalCollectionModuleClass: aClass [
	globalCollectionModuleClass := aClass
]

{ #category : #builders }
LcsDomainClassWithGlobalCollectionBuilderJob >> globalCollectionReferenceSlotBuilder [
	^ LcsGlobalCollectionReferenceSlotBuilder new
		targetClassName: self newDomainClassName;
		collectionSlotName: self globalCollectionSlotName;
		collectionSlotModuleName: self globalCollectionModuleClass defaultModuleName;
		collectionClassName: self globalCollectionClassName;
		yourself
]

{ #category : #accessing }
LcsDomainClassWithGlobalCollectionBuilderJob >> globalCollectionSlotName [
	^ globalCollectionSlotName
]

{ #category : #accessing }
LcsDomainClassWithGlobalCollectionBuilderJob >> globalCollectionSlotName: aString [
	globalCollectionSlotName := aString
]

{ #category : #initialize }
LcsDomainClassWithGlobalCollectionBuilderJob >> initialize [
	super initialize.
	self classPrefix: 'Lcs'.
]

{ #category : #initialize }
LcsDomainClassWithGlobalCollectionBuilderJob >> installGlobalCollectionSlotInModuleClass: aClass [
	self globalCollectionModuleClass: aClass 
]

{ #category : #configuration }
LcsDomainClassWithGlobalCollectionBuilderJob >> installMemberSlotInDomainClass: aClass [ 
	self targetDomainClasses add: aClass
]

{ #category : #configuration }
LcsDomainClassWithGlobalCollectionBuilderJob >> installNewClassesInPackageNamed: aString [ 
	self targetPackageName: aString
]

{ #category : #builders }
LcsDomainClassWithGlobalCollectionBuilderJob >> memberOfSlotBuilderFor: aTargetClass [ 
	^ LcsMemberOfSlotBuilder new
		targetClassName: aTargetClass name;
		slotName: self domainInstanceSlotName;
		collectionSlotName: self globalCollectionSlotName;
		collectionSlotModuleName: self globalCollectionModuleClass defaultModuleName;
		addSlotType: self newDomainClassName;
		yourself
]

{ #category : #accessing }
LcsDomainClassWithGlobalCollectionBuilderJob >> newDomainClassName [
	^ newDomainClassName
]

{ #category : #accessing }
LcsDomainClassWithGlobalCollectionBuilderJob >> newDomainClassName: anObject [ 
	newDomainClassName := anObject
]

{ #category : #accessing }
LcsDomainClassWithGlobalCollectionBuilderJob >> newGlobalCollectionClassName: anObject [ 
	self globalCollectionClassName: self classPrefix , anObject
]

{ #category : #accessing }
LcsDomainClassWithGlobalCollectionBuilderJob >> targetDomainClasses [
	^ targetDomainClasses
]

{ #category : #accessing }
LcsDomainClassWithGlobalCollectionBuilderJob >> targetDomainClasses: aCollection [
	targetDomainClasses := aCollection
]

{ #category : #asking }
LcsDomainClassWithGlobalCollectionBuilderJob >> targetModule [
	^ self currentSystem moduleNamed: self globalCollectionModuleClass defaultModuleName
]

{ #category : #accessing }
LcsDomainClassWithGlobalCollectionBuilderJob >> targetModuleClass [
	^ targetModuleClass
]

{ #category : #accessing }
LcsDomainClassWithGlobalCollectionBuilderJob >> targetModuleClass: aModuleClass [
	targetModuleClass := aModuleClass
]

{ #category : #accessing }
LcsDomainClassWithGlobalCollectionBuilderJob >> targetModuleName [
	^ targetModuleName
]

{ #category : #accessing }
LcsDomainClassWithGlobalCollectionBuilderJob >> targetModuleName: aString [
	targetModuleName := aString
]

{ #category : #accessing }
LcsDomainClassWithGlobalCollectionBuilderJob >> targetPackageName [
	^ targetPackageName
]

{ #category : #accessing }
LcsDomainClassWithGlobalCollectionBuilderJob >> targetPackageName: aString [ 
	targetPackageName := aString
]

{ #category : #command }
LcsDomainClassWithGlobalCollectionBuilderJob >> verifyPopulateSlotModel [
	self subclassResponsibility
]
