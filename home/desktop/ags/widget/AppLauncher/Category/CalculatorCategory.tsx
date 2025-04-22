import { bind, execAsync, Variable } from "astal";
import Category from "./Category";
import Item from "../Item";
import Icons from "../../../lib/icons";

function CalculatorCategory(query: Variable<string>) {
    const result = Variable("")
    query.subscribe(q => {
        if (q.startsWith('=')) {
            const expr = q.slice(1).trim()
            if (expr === "")
                result.set("")
            else
                execAsync(`qalc --terse ${expr}`).then(res => result.set(res)).catch(() => result.set(""))
        }
    })

    function copy() {
        execAsync(`wl-copy ${result.get()}`)
    }

    const item = <Item
        cssClasses={["calculator"]}
        iconName={Icons.ui.calculator}
        title={bind(result)}
        onClicked={copy}
        canFocus={false}
    />

    return <Category 
        name={"Calculator"}
        action={copy}
        child={item}
    />
}

export default CalculatorCategory
