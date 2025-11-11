Class {
	#name : #LcsSystemClassBuilder,
	#superclass : #LcsBaseModuleClassBuilder,
	#category : #'Lcs-SlotTools'
}

{ #category : #'job steps' }
LcsSystemClassBuilder >> buildJobSteps [
	super buildJobSteps.
	self addJobStep: self systemDomainClassesMethodBuilder.
	self addJobStep: self convenienceCreateSystemMethodBuilder.
	self addJobStep: self modifyOwningModulesMethodBuilder
]

{ #category : #'job steps' }
LcsSystemClassBuilder >> configurationSlotDefinitionSuperMethodBuilder [
	^ LcsConfigurationSlotDefinitionSuperMethodBuilder new
		targetClassName: self newClassName;
		selector: #configurationSlotDefinition;
		yourself
]

{ #category : #builders }
LcsSystemClassBuilder >> convenienceCreateSystemMethodBuilder [
	^ LcsConvenienceStartSystemMethodBuilder new
		beClassMethod;
		targetClassName: 'LcsApplicationEnvironment';
		categoryName: ('*' ,self targetPackageName) asSymbol;
		selector: (self selectorNameFrom: 'createNew' , self moduleName) asSymbol;
		systemClassName: self newClassName;
		yourself
]

{ #category : #builders }
LcsSystemClassBuilder >> modifyOwningModulesMethodBuilder [
	^ LcsModifyOwningModulesMethodBuilder new
		targetClassName: 'LcsSecurityModule';
		owningModuleClassName: self newClassName;
		yourself
]

{ #category : #builders }
LcsSystemClassBuilder >> systemDomainClassesMethodBuilder [
	^ LcsSystemDomainClassesMethodBuilder new
		targetClassName: self newClassName;
		categoryName: #'slot model';
		selector: 'systemDomainClasses' asSymbol;
		yourself
]

{ #category : #command }
LcsSystemClassBuilder >> verifySlotModelUpdatesMadeByBuilder [
	super verifySlotModelUpdatesMadeByBuilder.
	"A new system class is not part of the current system's slot model"
	self assert: self installedClass slotModel isNil
]
