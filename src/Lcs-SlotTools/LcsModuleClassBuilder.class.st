Class {
	#name : 'LcsModuleClassBuilder',
	#superclass : 'LcsBaseModuleClassBuilder',
	#instVars : [
		'owningModule',
		'owningModulePriority'
	],
	#category : 'Lcs-SlotTools',
	#package : 'Lcs-SlotTools'
}

{ #category : 'populate' }
LcsModuleClassBuilder >> _populateSlotModel [
	super _populateSlotModel.
	(self currentSystem moduleNamed: self owningModule defaultModuleName) buildModule: self installedClass
]

{ #category : 'job steps' }
LcsModuleClassBuilder >> buildJobSteps [
	super buildJobSteps.
	self addJobStep: self owningModulesMethodBuilder.
]

{ #category : 'accessing' }
LcsModuleClassBuilder >> owningModule [
	^ owningModule
]

{ #category : 'accessing' }
LcsModuleClassBuilder >> owningModule: anObject [ 
	owningModule := anObject
]

{ #category : 'accessing' }
LcsModuleClassBuilder >> owningModulePriority [
	^ owningModulePriority
]

{ #category : 'accessing' }
LcsModuleClassBuilder >> owningModulePriority: anObject [
	owningModulePriority := anObject
]

{ #category : 'builders' }
LcsModuleClassBuilder >> owningModulesMethodBuilder [
	^ LcsOwningModulesMethodBuilder new
		targetClassName: self newClassName;
		owningModuleClass: self owningModule;
		priority: self owningModulePriority;
		yourself
]
