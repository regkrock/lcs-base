Class {
	#name : 'LcsDomainClassAndDomainCollectionClassBuilderJob',
	#superclass : 'LcsCodeBuilderJob',
	#instVars : [
		'classPrefix',
		'targetPackageName',
		'domainInstanceSlotName',
		'classRootName',
		'targetDomainClasses',
		'targetModuleName',
		'targetModuleClass',
		'newDomainClassName',
		'unknownClassName',
		'collectionClassName',
		'collectionSlotName',
		'collectionSlotInstallationTargetClass',
		'newDomainClassSuperclass'
	],
	#category : 'Lcs-SlotTools',
	#package : 'Lcs-SlotTools'
}

{ #category : 'builders' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> _targetDoainClasses [
	^ self targetDomainClasses
		collect: [ :each | each isString ifTrue: [ each asClass ] ifFalse: [ each ] ]
]

{ #category : 'builders' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> addLocalCollectionSlotBuildersForTargetClasses [
	self _targetDoainClasses
		do: [ :eachClass | self addJobStep: (self localCollectionSlotBuilderFor:  eachClass) ]
]

{ #category : 'builders' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> addMemberOfSlotBuilderForTargetClasses [
	self _targetDoainClasses
		do: [ :eachClass | self addJobStep: (self memberOfSlotBuilderFor: eachClass) ]
]

{ #category : 'accessing' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> classPrefix [
	^ classPrefix
]

{ #category : 'accessing' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> classPrefix: aString [
	classPrefix := aString.
	self generateRelatedNames
]

{ #category : 'accessing' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> classRootName [
	^ classRootName
]

{ #category : 'accessing' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> classRootName: aString [
	classRootName := aString.
	self generateRelatedNames
]

{ #category : 'accessing' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> collectionClassName [
	^ collectionClassName
]

{ #category : 'accessing' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> collectionClassName: anObject [ 
	collectionClassName := anObject
]

{ #category : 'accessing' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> collectionModuleClass [
	^ self collectionSlotInstallationTargetClass
]

{ #category : 'builders' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> collectionReferenceSlotBuilder [
	^ LcsGlobalCollectionReferenceSlotBuilder new
		targetClassName: self newDomainClassName;
		collectionSlotName: self collectionSlotName;
		collectionSlotModuleName: self collectionModuleClass defaultModuleName;
		addSlotType: self collectionClassName;
		yourself
]

{ #category : 'accessing' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> collectionSlotInstallationTargetClass [
	^ collectionSlotInstallationTargetClass
]

{ #category : 'accessing' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> collectionSlotInstallationTargetClass: aClass [
	collectionSlotInstallationTargetClass := aClass
]

{ #category : 'accessing' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> collectionSlotName [
	^ collectionSlotName
]

{ #category : 'accessing' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> collectionSlotName: aString [
	collectionSlotName := aString
]

{ #category : 'configuration' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> createForPrefix: aPrefix rootName: aRootName [
	self classPrefix: aPrefix.
	self createForRootName: aRootName
]

{ #category : 'configuration' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> createForRootName: aRootName [
	self classRootName: aRootName.
	"self domainInstanceSlotName: self classRootName asValidSelector.
	self collectionSlotName: self domainInstanceSlotName asEnglishPlural.
	self newDomainClassName: self classPrefix , aRootName.
	self collectionClassName: self newDomainClassName asEnglishPlural"
]

{ #category : 'accessing' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> domainInstanceSlotName [
	^ domainInstanceSlotName
]

{ #category : 'accessing' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> domainInstanceSlotName: aString [ 
	domainInstanceSlotName := aString
]

{ #category : 'configuration' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> generateRelatedNames [
	(self classRootName isNil or: [ self classPrefix isNil ])
		ifTrue: [
			self domainInstanceSlotName: nil.
			self collectionSlotName: nil.
			self newDomainClassName: nil.
			self collectionClassName: nil.
			^ self ].
	self domainInstanceSlotName: self classRootName asValidSelector.
	self collectionSlotName: self domainInstanceSlotName asEnglishPlural.
	self newDomainClassName: self classPrefix , self classRootName.
	self collectionClassName: self newDomainClassName asEnglishPlural
]

{ #category : 'initialize' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> initialize [
	super initialize.
	self classPrefix: 'Lcs'.
	self newDomainClassSuperclass: 'LcsDomainObject'
]

{ #category : 'initialize' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> installCollectionSlotInClass: aClass [
	self collectionSlotInstallationTargetClass: aClass 
]

{ #category : 'configuration' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> installMemberSlotInDomainClass: aClass [ 
	self targetDomainClasses add: aClass
]

{ #category : 'configuration' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> installNewClassesInPackageNamed: aString [ 
	self targetPackageName: aString
]

{ #category : 'builders' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> localCollectionSlotBuilderFor: aTargetClass [ 
	^ LcsLocalCollectionSlotBuilder new
		slotName: self collectionSlotName;
		addSlotType: self collectionClassName;
		targetClassName: aTargetClass name;
		targetModuleClass: aTargetClass;
		targetPackageName: self targetPackageName;
		collectionMemberTypes: (OrderedCollection with: self newDomainClassName);
		yourself
]

{ #category : 'builders' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> memberOfSlotBuilderFor: aTargetClass [ 
	^ LcsMemberOfGlobalCollectionSlotBuilder new
			targetClassName: aTargetClass name;
			slotName: self domainInstanceSlotName;
			collectionSlotName: self collectionSlotName;
			collectionSlotModuleName: self collectionModuleClass defaultModuleName;
			addSlotType: self newDomainClassName;
			collectionSourceClassName: self collectionClassName;
			yourself
]

{ #category : 'accessing' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> newDomainClassName [
	^ newDomainClassName
]

{ #category : 'accessing' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> newDomainClassName: anObject [ 
	newDomainClassName := anObject
]

{ #category : 'accessing' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> newDomainClassSuperclass [
	^ newDomainClassSuperclass
]

{ #category : 'accessing' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> newDomainClassSuperclass: anObject [ 
	newDomainClassSuperclass := anObject
]

{ #category : 'accessing' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> targetDomainClasses [
	^ targetDomainClasses
]

{ #category : 'accessing' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> targetDomainClasses: aCollection [
	targetDomainClasses := aCollection
]

{ #category : 'asking' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> targetModule [
	^ self currentSystem moduleNamed: self collectionModuleClass defaultModuleName
]

{ #category : 'accessing' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> targetModuleClass [
	^ targetModuleClass
]

{ #category : 'accessing' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> targetModuleClass: aModuleClass [
	targetModuleClass := aModuleClass
]

{ #category : 'accessing' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> targetModuleName [
	^ targetModuleName
]

{ #category : 'accessing' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> targetModuleName: aString [
	targetModuleName := aString
]

{ #category : 'accessing' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> targetPackageName [
	^ targetPackageName
]

{ #category : 'accessing' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> targetPackageName: aString [ 
	targetPackageName := aString
]

{ #category : 'accessing' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> targetPackageTagName: anObject [
	targetPackageTagName := anObject
]

{ #category : 'accessing' }
LcsDomainClassAndDomainCollectionClassBuilderJob >> unknownClassName [
	^ nil
]
