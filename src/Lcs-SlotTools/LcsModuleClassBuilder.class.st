Class {
	#name : #LcsModuleClassBuilder,
	#superclass : #LcsDomainClassBuilder,
	#instVars : [
		'owningModule'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #populate }
LcsModuleClassBuilder >> _populateSlotModel [
	super _populateSlotModel.
	(self currentSystem moduleNamed: self owningModule defaultModuleName) buildModule: self installedClass
]

{ #category : #'job steps' }
LcsModuleClassBuilder >> buildJobSteps [
	self addJobStep: self moduleNameMethodBuilder.
	self addJobStep: self owningModulesMethodBuilder.
	self addJobStep: self convenienceModuleAccessMethodBuilder
]

{ #category : #builders }
LcsModuleClassBuilder >> convenienceModuleAccessMethodBuilder [
	^ LcsConvenienceModuleAccessMethodBuilder new
		extendInPackage: self targetPackageName;
		selector: (self selectorNameFrom: self moduleName);
		moduleName: self moduleName;
		yourself
]

{ #category : #properties }
LcsModuleClassBuilder >> moduleName [
	^ self properties at: 'moduleName'
]

{ #category : #properties }
LcsModuleClassBuilder >> moduleName: aString [
	self propertyAt: 'moduleName' put: aString
]

{ #category : #builders }
LcsModuleClassBuilder >> moduleNameMethodBuilder [
	^ LcsModuleNameMethodBuilder new
		targetClassName: self newClassName;
		beClassMethod;
		moduleName: self moduleName;
		categoryName: #configuration;
		yourself
]

{ #category : #accessing }
LcsModuleClassBuilder >> owningModule [
	^ owningModule
]

{ #category : #accessing }
LcsModuleClassBuilder >> owningModule: anObject [ 
	owningModule := anObject
]

{ #category : #builders }
LcsModuleClassBuilder >> owningModulesMethodBuilder [
	^ LcsOwningModulesMethodBuilder new
		targetClassName: self newClassName;
		owningModuleClass: self owningModule;
		yourself
]
