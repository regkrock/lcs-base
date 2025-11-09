Class {
	#name : #LcsSystenBuilderJob,
	#superclass : #LcsCodeBuilderJob,
	#instVars : [
		'classPrefix',
		'classRootName',
		'newDomainClassName',
		'targetPackageTagName',
		'targetPackageName',
		'moduleName'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #'builder job' }
LcsSystenBuilderJob >> buildJobSteps [
	self addJobStep: self configurationClassBuilder.
	self addJobStep: self systemClassBuilder.
	self addJobStep: self configurationSlotBuilder.
]

{ #category : #accessing }
LcsSystenBuilderJob >> classPrefix [
	^ classPrefix
]

{ #category : #accessing }
LcsSystenBuilderJob >> classPrefix: aString [
	classPrefix := aString.
	self generateRelatedNames
]

{ #category : #accessing }
LcsSystenBuilderJob >> classRootName [
	^ classRootName
]

{ #category : #accessing }
LcsSystenBuilderJob >> classRootName: aString [
	classRootName := aString.
	self generateRelatedNames
]

{ #category : #builders }
LcsSystenBuilderJob >> configurationClassBuilder [
	^ LcsSystemConfigurationClassBuilder new
		targetSuperclassName: LcsBaseConfiguration name;
		newTargetClassName: self systemConfigurationClassName;
		targetPackageName: self targetPackageName;
		targetPackageTagName: self targetPackageTagName;
		yourself
]

{ #category : #builders }
LcsSystenBuilderJob >> configurationSlotBuilder [
	^ LcsAccessorSlotBuilder new
		targetClassName: self newDomainClassName;
		slotClassName: LcsModuleConfigurationSlot name;
		slotName: 'configuration';
		addSlotType: self systemConfigurationClassName;
		yourself
]

{ #category : #configuration }
LcsSystenBuilderJob >> createForRootName: aRootName [
	self classRootName: aRootName.
	self generateRelatedNames
]

{ #category : #command }
LcsSystenBuilderJob >> execute [
	"Buildng new system classes - there is no current model which to add the new classes, etc. "
	self jobSteps isEmpty ifTrue: [self buildJobSteps].
	self installCode.
	self verifyCodeInstallation
]

{ #category : #configuration }
LcsSystenBuilderJob >> generateRelatedNames [
	super generateRelatedNames.
	(self classRootName isNil or: [ self classPrefix isNil ])
		ifTrue: [
			self newDomainClassName: nil.
			^ self ].
	self newDomainClassName: self classPrefix , self classRootName.
	self targetPackageName: self classPrefix , '-' , self classRootName.
	self targetPackageTagName: 'Core'.
]

{ #category : #accessing }
LcsSystenBuilderJob >> moduleName [
	^ moduleName
]

{ #category : #accessing }
LcsSystenBuilderJob >> moduleName: aString [
	moduleName := aString
]

{ #category : #accessing }
LcsSystenBuilderJob >> newDomainClassName [
	^ newDomainClassName
]

{ #category : #accessing }
LcsSystenBuilderJob >> newDomainClassName: anObject [ 
	newDomainClassName := anObject
]

{ #category : #builders }
LcsSystenBuilderJob >> systemClassBuilder [
	^ LcsSystemClassBuilder new
		targetSuperclassName: LcsSystem name;
		newTargetClassName: self newDomainClassName;
		targetPackageName: self targetPackageName;
		moduleName: self moduleName;
		yourself
]

{ #category : #accessing }
LcsSystenBuilderJob >> systemConfigurationClassName [
	^ self classPrefix , self classRootName , 'Configuration'
]

{ #category : #accessing }
LcsSystenBuilderJob >> targetPackageName [
	^ targetPackageName
]

{ #category : #accessing }
LcsSystenBuilderJob >> targetPackageName: aString [ 
	targetPackageName := aString
]

{ #category : #accessing }
LcsSystenBuilderJob >> targetPackageTagName [
	^ targetPackageTagName
]

{ #category : #accessing }
LcsSystenBuilderJob >> targetPackageTagName: anObject [
	targetPackageTagName := anObject
]
