Class {
	#name : #LcsSystemClassBuilder,
	#superclass : #LcsDomainClassBuilder,
	#category : #'Lcs-SlotTools'
}

{ #category : #'job steps' }
LcsSystemClassBuilder >> buildJobSteps [
	self addJobStep: self moduleNameMethodBuilder.
	self addJobStep: self convenienceModuleAccessMethodBuilder.
	self addJobStep: self systemDomainClassesMethodBuilder.
	self addJobStep: self convenienceCreateSystemMethodBuilder
]

{ #category : #'job steps' }
LcsSystemClassBuilder >> convenienceCreateSystemMethodBuilder [
	^ LcsConvenienceStartSystemMethodBuilder new
		targetClassName: 'LcsApplicationEnvironment';
		categoryName: ('*' ,self targetPackageName) asSymbol;
		selector: (self selectorNameFrom: 'createNew' , self moduleName);
		systemClassName: self newClassName;
		yourself
]

{ #category : #builders }
LcsSystemClassBuilder >> convenienceModuleAccessMethodBuilder [
	^ LcsConvenienceModuleAccessMethodBuilder new
		targetClassName: 'LcsModule';
		categoryName: ('*' ,self targetPackageName) asSymbol;
		selector: (self selectorNameFrom: self moduleName);
		moduleName: self moduleName;
		yourself
]

{ #category : #properties }
LcsSystemClassBuilder >> moduleName [
	^ self properties at: 'moduleName'
]

{ #category : #properties }
LcsSystemClassBuilder >> moduleName: aString [
	self propertyAt: 'moduleName' put: aString
]

{ #category : #builders }
LcsSystemClassBuilder >> moduleNameMethodBuilder [
	^ LcsModuleNameMethodBuilder new
		targetClassName: self newClassName;
		beClassMethod;
		moduleName: self moduleName;
		categoryName: #configuration;
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
