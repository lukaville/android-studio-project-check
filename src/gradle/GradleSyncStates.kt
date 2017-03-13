package gradle

import com.android.tools.idea.gradle.project.sync.GradleSyncInvoker
import com.android.tools.idea.gradle.project.sync.GradleSyncListener
import com.android.tools.idea.gradle.project.sync.GradleSyncState
import com.intellij.openapi.project.Project

fun Project.sync(listener: (error: String?) -> Unit) {
    GradleSyncState.subscribe(this, object : GradleSyncListener {

        override fun syncFailed(project: Project, error: String) {
            println("Project sync failed")
            listener(error)
        }

        override fun setupStarted(p0: Project) {
            println("Project setup started")
        }

        override fun syncStarted(project: Project) {
            println("Project sync started")
        }

        override fun syncSkipped(project: Project) {
            println("Project sync skipped")
            listener(null)
        }

        override fun syncSucceeded(project: Project) {
            println("Project sync succeeded")
            listener(null)
        }
    })

    val request = GradleSyncInvoker.Request().setUseCachedGradleModels(false)
    GradleSyncInvoker.getInstance().requestProjectSync(this, request, null)
}