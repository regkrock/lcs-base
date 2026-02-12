Class {
	#name : 'LcsSystemBuilderJob',
	#superclass : 'LcsCodeBuilderJob',
	#instVars : [
		'classPrefix',
		'classRootName',
		'newDomainClassName',
		'targetPackageName',
		'moduleName'
	],
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'builder job' }
LcsSystemBuilderJob >> buildJobSteps [
	self addJobStep: self configurationClassBuilder.
	self addJobStep: self systemClassBuilder
]

{ #category : 'accessing' }
LcsSystemBuilderJob >> classPrefix [
	^ classPrefix
]

{ #category : 'accessing' }
LcsSystemBuilderJob >> classPrefix: aString [
	classPrefix := aString.
	self generateRelatedNames
]

{ #category : 'accessing' }
LcsSystemBuilderJob >> classRootName [
	^ classRootName
]

{ #category : 'accessing' }
LcsSystemBuilderJob >> classRootName: aString [
	classRootName := aString.
	self generateRelatedNames
]

{ #category : 'builders' }
LcsSystemBuilderJob >> configurationClassBuilder [
	^ LcsSystemConfigurationClassBuilder new
		targetSuperclassName: LcsBaseConfiguration name;
		newTargetClassName: self systemConfigurationClassName;
		targetPackageName: self targetPackageName;
		targetPackageTagName: self targetPackageTagName;
		yourself
]

{ #category : 'configuration' }
LcsSystemBuilderJob >> createForRootName: aRootName [
	self classRootName: aRootName.
	self generateRelatedNames
]

{ #category : 'command' }
LcsSystemBuilderJob >> execute [
	"Buildng new system classes - there is no current model which to add the new classes, etc. "
	self jobSteps isEmpty ifTrue: [self buildJobSteps].
	self installCode.
	self verifyCodeInstallation
]

{ #category : 'configuration' }
LcsSystemBuilderJob >> generateRelatedNames [
	super generateRelatedNames.
	(self classRootName isNil or: [ self classPrefix isNil ])
		ifTrue: [
			self newDomainClassName: nil.
			^ self ].
	self newDomainClassName: self classPrefix , self classRootName.
	self targetPackageName: self classPrefix , '-' , self classRootName.
	self targetPackageTagName: 'Core'.
]

{ #category : 'accessing' }
LcsSystemBuilderJob >> moduleName [
	^ moduleName
]

{ #category : 'accessing' }
LcsSystemBuilderJob >> moduleName: aString [
	moduleName := aString
]

{ #category : 'accessing' }
LcsSystemBuilderJob >> newDomainClassName [
	^ newDomainClassName
]

{ #category : 'accessing' }
LcsSystemBuilderJob >> newDomainClassName: anObject [ 
	newDomainClassName := anObject
]

{ #category : 'builders' }
LcsSystemBuilderJob >> systemClassBuilder [
	^ LcsSystemClassBuilder new
		targetSuperclassName: LcsSystem name;
		newTargetClassName: self newDomainClassName;
		targetPackageName: self targetPackageName;
		moduleName: self moduleName;
		configurationClassName: self systemConfigurationClassName;
		yourself
]

{ #category : 'accessing' }
LcsSystemBuilderJob >> systemConfigurationClassName [
	^ self classPrefix , self classRootName , 'Configuration'
]

{ #category : 'accessing' }
LcsSystemBuilderJob >> targetPackageName [
	^ targetPackageName
]

{ #category : 'accessing' }
LcsSystemBuilderJob >> targetPackageName: aString [ 
	targetPackageName := aString
]

{ #category : 'accessing' }
LcsSystemBuilderJob >> targetPackageTagName: anObject [
	targetPackageTagName := anObject
]
