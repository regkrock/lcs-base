Class {
	#name : #LcsBaseModuleClassBuilder,
	#superclass : #LcsDomainClassBuilder,
	#category : #'Lcs-SlotTools'
}

{ #category : #'job steps' }
LcsBaseModuleClassBuilder >> buildJobSteps [
	self addJobStep: self moduleNameMethodBuilder.
	self addJobStep: self convenienceModuleAccessMethodBuilder.
	self addJobStep: self moduleConfigurationClassMethodBuilder
]

{ #category : #properties }
LcsBaseModuleClassBuilder >> configurationClassName [
	^ self properties at: 'configurationClassName'
]

{ #category : #properties }
LcsBaseModuleClassBuilder >> configurationClassName: aString [
	self propertyAt: 'configurationClassName' put: aString
]

{ #category : #builders }
LcsBaseModuleClassBuilder >> convenienceModuleAccessMethodBuilder [
	^ LcsConvenienceModuleAccessMethodBuilder new
		extendInPackage: self targetPackageName;
		selector: (self selectorNameFrom: self moduleName);
		moduleName: self moduleName;
		yourself
]

{ #category : #'job steps' }
LcsBaseModuleClassBuilder >> moduleConfigurationClassMethodBuilder [
	^ LcsModuleConfigurationClassMethodBuilder new
		targetClassName: self newClassName;
		configurationClassName: self configurationClassName;
		yourself
]

{ #category : #properties }
LcsBaseModuleClassBuilder >> moduleName [
	^ self properties at: 'moduleName'
]

{ #category : #properties }
LcsBaseModuleClassBuilder >> moduleName: aString [
	self propertyAt: 'moduleName' put: aString
]

{ #category : #builders }
LcsBaseModuleClassBuilder >> moduleNameMethodBuilder [
	^ LcsModuleNameMethodBuilder new
		targetClassName: self newClassName;
		beClassMethod;
		moduleName: self moduleName;
		categoryName: #configuration;
		yourself
]
