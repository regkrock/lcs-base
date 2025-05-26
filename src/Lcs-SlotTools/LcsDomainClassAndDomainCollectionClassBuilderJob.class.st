Class {
	#name : #LcsDomainClassAndDomainCollectionClassBuilderJob,
	#superclass : #LcsCodeBuilderJob,
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
		'collectionSlotInstallationTargetClass'
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

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> collectionClassName [
	^ collectionClassName
]

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> collectionClassName: anObject [ 
	collectionClassName := anObject
]

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> collectionModuleClass [
	^ collectionSlotInstallationTargetClass
]

{ #category : #builders }
LcsDomainClassAndDomainCollectionClassBuilderJob >> collectionReferenceSlotBuilder [
	^ LcsGlobalCollectionReferenceSlotBuilder new
		targetClassName: self newDomainClassName;
		collectionSlotName: self collectionSlotName;
		collectionSlotModuleName: self collectionModuleClass defaultModuleName;
		addSlotType: self collectionClassName;
		yourself
]

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> collectionSlotInstallationTargetClass: aClass [
	collectionSlotInstallationTargetClass := aClass
]

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> collectionSlotName [
	^ collectionSlotName
]

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> collectionSlotName: aString [
	collectionSlotName := aString
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
	self collectionSlotName: self domainInstanceSlotName asEnglishPlural.
	self newDomainClassName: self classPrefix , aRootName.
	self collectionClassName: self newDomainClassName asEnglishPlural
]

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> domainInstanceSlotName [
	^ domainInstanceSlotName
]

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> domainInstanceSlotName: aString [ 
	domainInstanceSlotName := aString
]

{ #category : #initialize }
LcsDomainClassAndDomainCollectionClassBuilderJob >> initialize [
	super initialize.
	self classPrefix: 'Lcs'.
]

{ #category : #initialize }
LcsDomainClassAndDomainCollectionClassBuilderJob >> installCollectionSlotInClass: aClass [
	self collectionSlotInstallationTargetClass: aClass 
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
		collectionSlotName: self collectionSlotName;
		collectionSlotModuleName: self collectionModuleClass defaultModuleName;
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
LcsDomainClassAndDomainCollectionClassBuilderJob >> targetDomainClasses [
	^ targetDomainClasses
]

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> targetDomainClasses: aCollection [
	targetDomainClasses := aCollection
]

{ #category : #asking }
LcsDomainClassAndDomainCollectionClassBuilderJob >> targetModule [
	^ self currentSystem moduleNamed: self collectionModuleClass defaultModuleName
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

{ #category : #accessing }
LcsDomainClassAndDomainCollectionClassBuilderJob >> unknownClassName [
	^ nil
]
