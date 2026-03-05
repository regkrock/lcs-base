Class {
	#name : 'LcsDomainClassAndLocalCollectionClassBuilderJobTest',
	#superclass : 'LcsCodeJobBuilderTest',
	#category : 'Lcs-SlotToolsTests-Tests',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Tests'
}

{ #category : 'private' }
LcsDomainClassAndLocalCollectionClassBuilderJobTest >> createLxxInvoiceAndLxxInvoices [
	self currentCodeBuilderJob:
		(LcsDomainClassAndGlobalCollectionClassBuilderJob new
			classPrefix: 'Lxx';
			createForRootName: 'Invoice';
			installNewClassesInPackageNamed: 'Lcs-Temp';
			installCollectionSlotInClass: LxxPrototypeSystem;
			buildJobSteps;
			yourself).
	self currentCodeBuilderJob execute.
	self assert: self currentSystem invoices notNil.
	self assert: (self currentSystem invoices isKindOf: #LxxInvoices asClass)
]

{ #category : 'private' }
LcsDomainClassAndLocalCollectionClassBuilderJobTest >> invoiceAndInvoicesBuilderJob [
	^ LcsDomainClassAndGlobalCollectionClassBuilderJobExamples new invoiceAndInvoicesBuilderJob
]

{ #category : 'tests' }
LcsDomainClassAndLocalCollectionClassBuilderJobTest >> invoiceItemAndLocalInvoiceItemsCreationJob [
	<gtExample>
	| builderJob |
	builderJob :=  self newBuilderJob
					classPrefix: 'Lxx';
					createForRootName: 'InvoiceItem';
					installNewClassesInPackageNamed: 'Lcs-Temp';
					"installCollectionSlotInClass: #LxxInvoice asClass;"
					installCollectionSlotInClassName: #LxxInvoice;
					yourself.
	"self error: 'Add tests here to sort out the problem when the class does not yet exist.'."
	builderJob buildJobSteps.
	^ builderJob
]

{ #category : 'tests' }
LcsDomainClassAndLocalCollectionClassBuilderJobTest >> invoiceItemAndLocalInvoiceItemsCreationJobInstallationAndRemoval [
	<gtExample>
	| builderJob invoiceBuilderJob|
	invoiceBuilderJob := self invoiceAndInvoicesBuilderJob.
	builderJob :=  self invoiceItemAndLocalInvoiceItemsCreationJob.
	[ invoiceBuilderJob execute.
	  invoiceBuilderJob verifyCodeInstallation.
	  builderJob execute.
	  builderJob verifyCodeInstallation.
	  self verifyInstallationOf: builderJob ]
		ensure: [
			builderJob uninstall.
			builderJob verifyUninstall.
			invoiceBuilderJob uninstall.
			invoiceBuilderJob verifyUninstall ].
	^ builderJob

]

{ #category : 'examples' }
LcsDomainClassAndLocalCollectionClassBuilderJobTest >> newBuilderJob [
	<gtExample>
	| builderJob |
	builderJob := LcsDomainClassAndLocalCollectionClassBuilderJob new.
	^ builderJob
]

{ #category : 'validation' }
LcsDomainClassAndLocalCollectionClassBuilderJobTest >> verifyInstallationOf: builderJob [ 
	| newInvoice newInvoiceItem |
	
	"This code creates ok but there is problems when the changes 
	 are uninstalled. The instances need to be removed first."
	
	"newInvoice := #LxxInvoice asClass new.
	self assert: newInvoice invoiceItems collectionSize = 0.
	self assert: (newInvoice invoiceItems isKindOf: #LxxInvoiceItems asClass).
	"self currentSystem applyChanges."
	newInvoiceItem := newInvoice invoiceItems add: #LxxInvoiceItem asClass new.
	self assert: newInvoiceItem parent == newInvoice invoiceItems.
	"self currentSystem applyChanges."
	self assert: (newInvoice invoiceItems includes: newInvoiceItem)"
]
