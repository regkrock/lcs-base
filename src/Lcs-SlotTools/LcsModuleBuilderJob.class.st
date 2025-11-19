Class {
	#name : 'LcsModuleBuilderJob',
	#superclass : 'LcsCodeBuilderJob',
	#instVars : [
		'classPrefix',
		'classRootName',
		'newDomainClassName',
		'targetPackageName',
		'moduleName',
		'owningModule'
	],
	#category : 'Lcs-SlotTools',
	#package : 'Lcs-SlotTools'
}

{ #category : 'builder job' }
LcsModuleBuilderJob >> buildJobSteps [
	self addJobStep: self configurationClassBuilder.
	self addJobStep: self moduleClassBuilder
]

{ #category : 'accessing' }
LcsModuleBuilderJob >> classPrefix [
	^ classPrefix
]

{ #category : 'accessing' }
LcsModuleBuilderJob >> classPrefix: aString [
	classPrefix := aString.
	self generateRelatedNames
]

{ #category : 'accessing' }
LcsModuleBuilderJob >> classRootName [
	^ classRootName
]

{ #category : 'accessing' }
LcsModuleBuilderJob >> classRootName: aString [
	classRootName := aString.
	self generateRelatedNames
]

{ #category : 'builders' }
LcsModuleBuilderJob >> configurationClassBuilder [
	^ LcsDomainClassBuilder new
		targetSuperclassName: LcsBaseConfiguration name;
		newTargetClassName: self moduleConfigurationClassName;
		targetPackageName: self targetPackageName;
		targetPackageTagName: self targetPackageTagName;
		yourself
]

{ #category : 'configuration' }
LcsModuleBuilderJob >> createForRootName: aRootName [
	self classRootName: aRootName.
	self generateRelatedNames
]

{ #category : 'configuration' }
LcsModuleBuilderJob >> generateRelatedNames [
	super generateRelatedNames.
	(self classRootName isNil or: [ self classPrefix isNil ])
		ifTrue: [
			self newDomainClassName: nil.
			^ self ].
	self newDomainClassName: self classPrefix , self classRootName , 'Module'.
	self targetPackageName: self classPrefix , '-' , self classRootName.
	self targetPackageTagName: 'Core'.
]

{ #category : 'builders' }
LcsModuleBuilderJob >> moduleClassBuilder [
	^ LcsModuleClassBuilder new
		targetSuperclassName: LcsModule name;
		newTargetClassName: self newDomainClassName;
		targetPackageName: self targetPackageName;
		moduleName: self moduleName;
		owningModule: self owningModule;
		configurationClassName: self moduleConfigurationClassName;
		yourself
]

{ #category : 'accessing' }
LcsModuleBuilderJob >> moduleConfigurationClassName [
	self assert: self classRootName notNil.
	self assert: self classPrefix notNil.
	^ self classPrefix , self classRootName , 'ModuleConfiguration'
]

{ #category : 'accessing' }
LcsModuleBuilderJob >> moduleName [
	^ moduleName
]

{ #category : 'accessing' }
LcsModuleBuilderJob >> moduleName: aString [
	moduleName := aString
]

{ #category : 'accessing' }
LcsModuleBuilderJob >> newDomainClassName [
	^ newDomainClassName
]

{ #category : 'accessing' }
LcsModuleBuilderJob >> newDomainClassName: anObject [ 
	newDomainClassName := anObject
]

{ #category : 'accessing' }
LcsModuleBuilderJob >> owningModule [
	^ owningModule
]

{ #category : 'accessing' }
LcsModuleBuilderJob >> owningModule: anObject [
	owningModule := anObject
]

{ #category : 'accessing' }
LcsModuleBuilderJob >> targetPackageName [
	^ targetPackageName
]

{ #category : 'accessing' }
LcsModuleBuilderJob >> targetPackageName: aString [ 
	targetPackageName := aString
]

{ #category : 'accessing' }
LcsModuleBuilderJob >> targetPackageTagName [
	^ targetPackageTagName
]

{ #category : 'accessing' }
LcsModuleBuilderJob >> targetPackageTagName: anObject [
	targetPackageTagName := anObject
]
